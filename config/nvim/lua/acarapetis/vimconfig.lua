-- Configuration for [neo]vim builtin functionality
vim.opt.autoindent = true
vim.opt.backspace = "eol,start,indent"
vim.opt.cindent = false
vim.opt.expandtab = true
vim.opt.fileencodings = "ucs-bom,utf-8,default,latin1"
vim.opt.formatoptions = "cqjn"
vim.opt.grepprg = "grep -H $*"
vim.opt.helplang = "en"
vim.opt.hidden = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.laststatus = 2
--vim.opt.list = true
--vim.opt.listchars = "tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.ruler = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 7
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.smartcase = true
vim.opt.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"
vim.opt.tabstop = 4
vim.opt.textwidth = 88
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 300
vim.opt.wildmenu = true

-- Indent styles and scripts in html appropriately
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_script1 = "inc"

vim.cmd([[
    filetype plugin indent on
    au BufNewFile,BufRead *.hcl set ft=terraform
    autocmd FileType rst set ts=3 | set sw=3
    autocmd QuickFixCmdPost [^l]* cwindow
]])

vim.fn.sign_define("DiagnosticSignError", { text="", texthl="TextError" })
vim.fn.sign_define("DiagnosticSignWarn", { text="", texthl="TextWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text="", texthl="TextInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text="", texthl="TextHint" })
vim.diagnostic.config({
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "",
        },
        texthl = {
            [vim.diagnostic.severity.ERROR] = "TextError",
            [vim.diagnostic.severity.WARN] = "TextWarn",
            [vim.diagnostic.severity.INFO] = "TextInfo",
            [vim.diagnostic.severity.HINT] = "TextHint",
        }
    }
})

vim.opt.bg = "dark"
vim.cmd.colorscheme("gruvbox")
