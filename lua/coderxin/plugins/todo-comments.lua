-- import todo-comments safely
local todo_comments_setup, todo_comments = pcall(require, "todo-comments")
if not todo_comments_setup then
  return
end

-- Todo Comments Setup
todo_comments.setup {
    colors = {
        error = { "DiagnosticError", "ErrorMsg", "#de5d68" },
        warning = { "DiagnosticWarning", "WarningMsg", "#eeb927" },
        info = { "DiagnosticInfo", "#57a5e5" },
        hint = { "DiagnosticHint", "#bb70d2" },
        default = { "Identifier", "#de5d68" },
    },
}

