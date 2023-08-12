require("myvim.set")
require("myvim.remap")
require("mason").setup()
require("mason-lspconfig").setup()

local augroup = vim.api.nvim_create_augroup
local MyVimGroup = augroup('MyVim', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

function R(name)
    require("plenary.reload").reload_module(name)
end

-- shorten (40s) duration of highlighted yank
autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

-- trimming trailing whitespace
autocmd({"BufWritePre"}, {
    group = MyVimGroup,
    pattern = "*",
    command = [[%s/\s\+$//e]],
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
vim.cmd.colorscheme "catppuccin"

local system_name
if os.getenv("OS") == "Windows_NT" then
    system_name = "Windows"
else
    -- Unix-like system, check for specific distributions
    local handle = io.popen("uname -s")
    system_name = handle:read("*l")
    handle:close()
end
