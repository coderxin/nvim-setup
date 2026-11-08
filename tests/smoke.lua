-- Run with: nvim --headless -l tests/smoke.lua
local repo = vim.fs.dirname(vim.fs.dirname(vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":p")))
local source = vim.env.NVIM_TEST_DATA or vim.fn.stdpath("data")
local temp = vim.fn.tempname()
vim.fn.mkdir(temp .. "/data/nvim", "p")
local child
local function exec(code, args)
  return vim.rpcrequest(child, "nvim_exec_lua", code, args or {})
end
local ok, err = xpcall(function()
  -- Copies keep plugin builds, parser installs and Mason state out of the live setup.
  for _, name in ipairs({ "lazy", "site", "mason" }) do
    local from = source .. "/" .. name
    if vim.fn.isdirectory(from) == 1 then
      local command = { "cp", "-R", from, temp .. "/data/nvim/" .. name }
      if vim.fn.has("mac") == 1 then table.insert(command, 2, "-c") end
      local result = vim.system(command):wait()
      assert(result.code == 0, result.stderr)
    end
  end
  assert(vim.fn.isdirectory(temp .. "/data/nvim/lazy/lazy.nvim") == 1, "Install locked plugins first")
  vim.fn.mkdir(temp .. "/config", "p")
  assert(vim.uv.fs_symlink(repo, temp .. "/config/nvim"))
  child = vim.fn.jobstart({ vim.v.progpath, "--headless", "--embed",
    temp .. "/sample.py",
    "--cmd", "lua _smoke_errors = {}; local notify = vim.notify; vim.notify = function(msg, level, opts) if level == vim.log.levels.ERROR then table.insert(_smoke_errors, msg) end; return notify(msg, level, opts) end",
  }, {
    rpc = true,
    env = {
      XDG_CONFIG_HOME = temp .. "/config", XDG_DATA_HOME = temp .. "/data",
      XDG_STATE_HOME = temp .. "/state", XDG_CACHE_HOME = temp .. "/cache",
      NVIM_APPNAME = "nvim",
    },
  })
  assert(child > 0, "Failed to start child Neovim")
  exec([[
    assert(require("coderxin.plugins.treesitter"):wait(300000), "Parser installation failed")
    for lang, code in pairs({ lua = "local x = 1", python = "value = 1", ruby = "value = 1", rust = "fn main() {}", typescript = "const x: number = 1;" }) do
      local parser = vim.treesitter.get_string_parser(code, lang)
      assert(not parser:parse()[1]:root():has_error(), lang .. " parser failed")
    end
    assert(vim.g.mapleader == " ")
    assert(vim.fn.maparg("<Space>a", "n") ~= "", "Harpoon must use Space")
    assert(vim.fn.maparg("<Space>cc", "n") ~= "", "Comments must use Space")
    assert(vim.fn.maparg("<Space>cf", "n") ~= "", "Formatting must work before first save")
    assert(vim.fn.maparg("<Space>cf", "x") ~= "", "Visual formatting must be mapped")
    assert(not package.loaded.conform, "Formatting should still be lazy before use")
    assert(require("cmp_buffer").new():get_keyword_pattern({ option = {} }))
    local capabilities = vim.lsp.config.lua_ls.capabilities
    assert(capabilities.textDocument.completion.completionItem.snippetSupport)
    assert(not vim.lsp.is_enabled("rust_analyzer"), "Mason must not duplicate Rust")
    assert(not vim.lsp.is_enabled("ts_ls"), "Mason must not duplicate TypeScript")
    vim.o.undofile = false
    vim.cmd.edit(vim.fn.fnameescape(... .. "/sample.py"))
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "value=1", "other=2" })
  ]], { temp })
  exec([[
    -- Use a deterministic Python AST formatter to exercise Conform's real process path.
    local conform = require("conform")
    conform.formatters.smoke = {
      command = "python3", stdin = true,
      args = { "-c", "import ast,sys; print(ast.unparse(ast.parse(sys.stdin.read())))" },
    }
    conform.formatters_by_ft.python = { "smoke" }
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Space>cf", true, false, true), "x", false)
    assert(vim.wait(5000, function() return vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "value = 1" end), "Manual formatting failed")
    vim.api.nvim_buf_set_lines(0, 0, -1, false, { "value=3", "other=4" })
    vim.cmd.write()
    assert(vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == "value = 3", "Save formatting failed")
    local buf = vim.api.nvim_get_current_buf()
    local closing = false
    local client = vim.lsp.start({
      name = "smoke", root_dir = ..., bufnr = buf,
      cmd = function(dispatchers)
        return {
          request = function(method, _, callback)
            local result = method == "initialize" and { capabilities = { hoverProvider = true, referencesProvider = true, renameProvider = true } } or nil
            vim.schedule(function() callback(nil, result) end)
            return true, 1
          end,
          notify = function(method)
            if method == "exit" then closing = true; dispatchers.on_exit(0, 0) end
            return true
          end,
          is_closing = function() return closing end,
          terminate = function() closing = true; dispatchers.on_exit(0, 0) end,
        }
      end,
    })
    assert(vim.wait(3000, function() return vim.lsp.buf_is_attached(buf, client) and vim.fn.maparg("<Space>vrn", "n") ~= "" end), "LSP attachment failed")
    for _, key in ipairs({ "gd", "K", "<Space>vrr", "<Space>vca", "[d", "]d" }) do
      assert(vim.fn.maparg(key, "n") ~= "", "Missing LSP mapping: " .. key)
    end
    vim.diagnostic.set(vim.api.nvim_create_namespace("smoke"), buf, {
      { lnum = 0, col = 0, message = "first", severity = vim.diagnostic.severity.WARN },
      { lnum = 1, col = 0, message = "second", severity = vim.diagnostic.severity.ERROR },
    })
    vim.api.nvim_win_set_cursor(0, { 1, 0 })
    vim.fn.maparg("]d", "n", false, true).callback()
    assert(vim.api.nvim_win_get_cursor(0)[1] == 2, "]d must go forward")
    vim.fn.maparg("[d", "n", false, true).callback()
    assert(vim.api.nvim_win_get_cursor(0)[1] == 1, "[d must go backward")
    vim.cmd("Trouble diagnostics open")
    assert(vim.wait(3000, function() return require("trouble").is_open("diagnostics") end), "Trouble failed to open")
    require("trouble").close()
    assert(vim.fn.exists(":Trouble") == 2)
    for _, key in ipairs({ "<Space>xx", "<Space>xw", "<Space>xd", "<Space>xl", "<Space>xq", "gR" }) do
      local mapping = vim.fn.maparg(key, "n")
      assert(mapping:find("Trouble ", 1, true) and not mapping:find("TroubleToggle", 1, true), key)
    end
    vim.lsp.stop_client(client, true)
    assert(#_smoke_errors == 0, table.concat(_smoke_errors, "\n"))
  ]], { temp })
  print("PASS: startup, parsers, leader shortcuts, completion, pre-save/manual/save formatting, LSP attachment, diagnostic navigation and Trouble")
end, debug.traceback)
if child and child > 0 then
  pcall(vim.rpcnotify, child, "nvim_command", "qa!")
  if vim.fn.jobwait({ child }, 5000)[1] == -1 then vim.fn.jobstop(child) end
  vim.fn.jobwait({ child }, 5000)
end
vim.fn.delete(temp, "rf")
if not ok then io.stderr:write(err .. "\n"); vim.cmd("cquit 1") end
