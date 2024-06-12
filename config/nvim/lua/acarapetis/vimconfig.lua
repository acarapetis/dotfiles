-- Configuration for [neo]vim builtin functionality
vim.opt.autoindent = true
vim.opt.backspace = "eol,start,indent"
vim.opt.cindent = false
vim.opt.expandtab = true
vim.opt.fileencodings = "ucs-bom,utf-8,default,latin1"
vim.opt.grepprg = "grep -H $*"
vim.opt.helplang = "en"
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 2
vim.opt.list = true
vim.opt.listchars = "tab:→ ,nbsp:␣,trail:•,extends:⟩,precedes:⟨"
vim.opt.mouse = "a"
vim.opt.number = false
vim.opt.ruler = true
vim.opt.shiftwidth = 4
vim.opt.showcmd = true
vim.opt.smartcase = true
vim.opt.suffixes = ".bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc"
vim.opt.tabstop = 4
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 300
vim.opt.wildmenu = true

-- Indent styles and scripts in html appropriately
vim.g.html_indent_style1 = "inc"
vim.g.html_indent_script1 = "inc"

-- Automatically turn on folding in XML
vim.g.xml_syntax_folding = 1

vim.cmd([[
    filetype plugin indent on
    au FileType xml setlocal foldmethod=syntax
    au BufNewFile,BufRead *.hcl set ft=terraform
    autocmd FileType rst set ts=3 | set sw=3
    sign define DiagnosticSignError text=  texthl=TextError linehl= numhl= 
    sign define DiagnosticSignWarn text=  texthl=TextWarn linehl= numhl= 
    sign define DiagnosticSignInfo text=  texthl=TextInfo linehl= numhl= 
    sign define DiagnosticSignHint text=  texthl=TextHint linehl= numhl=
]])

vim.opt.bg = "dark"
vim.cmd.colorscheme("gruvbox")



