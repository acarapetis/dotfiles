return {
    {
        "morhetz/gruvbox",
        lazy = false,
        config = function()
            vim.opt.termguicolors = true
            vim.opt.bg = "dark"
            vim.g.gruvbox_bold = "1"
            vim.g.gruvbox_contrast_dark = "hard"
            vim.g.gruvbox_improved_strings = "0"
            vim.g.gruvbox_improved_warnings = "0"
            vim.cmd("colorscheme gruvbox")
            vim.cmd([[
                hi link pythonStatement GruvboxRedBold
                hi link pythonConditional GruvboxRedBold
                hi link pythonException GruvboxRedBold
                hi link pythonRepeat GruvboxRedBold
                hi link pythonOperator GruvboxRedBold
                hi link pythonAsync GruvboxRedBold
                hi CocFloating guibg=#32302f ctermbg=236
                hi link CocWarningFloat GruvboxYellow
                hi link CocWarningSign GruvboxYellowSign
                hi link CocErrorFloat GruvboxRed
                hi link CocErrorSign GruvboxRedSign
                hi link CocHintFloat GruvboxGreen
                hi link CocHintSign GruvboxGreenSign
                hi link CocInfoFloat GruvboxBlue
                hi link CocInfoSign GruvboxBlueSign
            ]])
        end,
    }
}
