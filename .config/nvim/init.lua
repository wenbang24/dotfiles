require("config.lazy")

vim.opt.shiftwidth = 4
vim.cmd.colorscheme "catppuccin"
vim.cmd.set "relativenumber"

-- Open Neo-tree when nvim starts, if no file is specified
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- only open neo-tree if no file is passed in args
    if vim.fn.argc() == 0 then
      require("neo-tree.command").execute({ toggle = false, dir = vim.loop.cwd() })
    end
  end,
})

vim.g.guard_config = {
    -- format on write to buffer
    fmt_on_save = true,
    -- use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = true,
    -- whether or not to save the buffer after formatting
    save_on_fmt = true,
    -- automatic linting
    auto_lint = true,
    -- how frequently can linters be called
    lint_interval = 500,
    -- show diagnostic after format done
    refresh_diagnostic = true,
}

require("toggleterm").setup{
    open_mapping = [[<c-t>]],
    direction = 'vertical',
    size = vim.o.columns * 0.3,
}

vim.keymap.set("n", "<leader>r", function()
  vim.cmd("w")  -- save file
  local target = vim.fn.expand("%:t:r")
  vim.cmd("TermExec cmd='c " .. target .. "' goback=0")
end, { silent = true })

