local fzf = function(command)
    return function() require("fzf-lua")[command]() end
end

return {
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                win_options = {
                    winbar = "%{v:lua.require('oil').get_current_dir()}",
                },
            })
        end,
        lazy = false,
        keys = {
            { "-", vim.cmd.Oil, desc = "Open parent directory" },
            {
                "_",
                function()
                    vim.cmd.vsplit()
                    vim.cmd.Oil()
                end,
                desc = "Open parent directory"
            },
        }
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "mini.nvim",
        },
        keys = {
            { "<space>p",           fzf("files"),                      desc = "by filename" },
            { "<space>f",           fzf("live_grep_native"),           desc = "grep" },
            { "<space>w",           fzf("grep_cword"),                 desc = "word under cursor" },
            { "<space>W",           fzf("grep_cWORD"),                 desc = "WORD under cursor" },
            { "<space>b",           fzf("buffers"),                    desc = "buffers" },
            { "<space>h",           fzf("oldfiles"),                   desc = "history" },
            { "<space>g",           fzf("git_status"),                 desc = "git status" },
            { "<space>a",           fzf("lsp_code_actions"),           desc = "code actions" },
            { "<space>s",           fzf("lsp_document_symbols"),       desc = "symbols in document" },
            { "<space>S",           fzf("lsp_live_workspace_symbols"), desc = "symbols in workspace" },
            { "<space>r",           fzf("lsp_references"),             desc = "references to word under cursor" },
            { "<space>c",           fzf("commands"),                   desc = "nvim commands" },
            { "<space><F1>",        fzf("helptags"),                   desc = "nvim help" },
            { "<space><Backspace>", fzf("resume"),                     desc = "resume last fzf" },
            { "<leader><leader>",   fzf("buffers"),                    desc = "buffers" },
            { "<leader>b",          fzf("buffers"),                    desc = "buffers" },
        },
        lazy = false,
        config = function()
            require("fzf-lua").setup({
                oldfiles = {
                    include_current_session = true,
                },
                lsp = {
                    symbols = {
                        symbol_style = 2,
                        symbol_fmt = function(s, opts) return s end,
                    }
                },
                winopts = {
                    fullscreen = true,
                    preview = {
                        flip_columns = 150,
                    },
                }
            })
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "UndoTree" },
        },
    },
    {
        "ggandor/leap.nvim",
        config = function()
            require("leap").setup()
        end,
        keys = {
            { "s", "<Plug>(leap)", mode="n", desc="leap" },
            { "S", "<Plug>(leap-from-window)", mode="n", desc="leap from window " },
            { "s", "<Plug>(leap-forward)", mode={"x","o"}, desc="leap forward" },
            { "S", "<Plug>(leap-backward)", mode={"x","o"}, desc="leap backward" },
        }
    }
}
