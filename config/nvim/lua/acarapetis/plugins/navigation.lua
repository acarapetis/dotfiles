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
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<C-p>",               function() require("fzf-lua").files() end,                      desc = "by filename" },
            { "<C-f>",               function() require("fzf-lua").live_grep_native() end,           desc = "grep" },
            { "<C-g>",               function() require("fzf-lua").grep_cword() end,                 desc = "word under cursor" },
            { "<C-b>",               function() require("fzf-lua").buffers() end,                    desc = "buffers" },
            { "<BS>",                function() require("fzf-lua").oldfiles() end,                   desc = "history" },
            { "<Leader>fp",          function() require("fzf-lua").files() end,                      desc = "by filename" },
            { "<Leader>ff",          function() require("fzf-lua").live_grep_native() end,           desc = "grep" },
            { "<Leader>fw",          function() require("fzf-lua").grep_cword() end,                 desc = "word under cursor" },
            { "<Leader>fW",          function() require("fzf-lua").grep_cword() end,                 desc = "WORD under cursor" },
            { "<Leader>fb",          function() require("fzf-lua").buffers() end,                    desc = "buffers" },
            { "<Leader>fh",          function() require("fzf-lua").oldfiles() end,                   desc = "history" },
            { "<Leader>fg",          function() require("fzf-lua").git_status() end,                 desc = "git status" },
            { "<Leader>fs",          function() require("fzf-lua").lsp_document_symbols() end,       desc = "symbols in document" },
            { "<Leader>fS",          function() require("fzf-lua").lsp_live_workspace_symbols() end, desc = "symbols in workspace" },
            { "<Leader>fr",          function() require("fzf-lua").lsp_references() end,             desc = "references to word under cursor" },
            { "<Leader>fc",          function() require("fzf-lua").commands() end,                   desc = "nvim commands" },
            { "<Leader><F1>",        function() require("fzf-lua").helptags() end,                   desc = "nvim help" },
            { "<Leader><Backspace>", function() require("fzf-lua").resume() end,                     desc = "resume last fzf" },
        },
        opts = {
            --fzf_opts = { ["--layout"] = "default" },
            --file_icon_padding = "P",
            oldfiles = {
                include_current_session = true,
            },
        },
        lazy = false,
        config = function()
            -- Open file finder if nvim started with no args
            vim.api.nvim_create_autocmd({ "VimEnter" }, {
                pattern = { "*" },
                callback = function()
                    local nargs = #vim.v.argv
                    if vim.v.argv[2] == "--embed" then
                        nargs = nargs - 1
                    end
                    if nargs <= 1 then
                        require("fzf-lua").files()
                    end
                end,
            })
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc = "UndoTree" },
        },
    },
}
