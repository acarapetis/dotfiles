local fzf = function(command, opts)
    return function() require("fzf-lua")[command](opts) end
end

-- Small fzf picker near the cursor
local sfzf = function(command)
    return function()
        ---@type integer
        ---@diagnostic disable-next-line: assign-type-mismatch
        local col = vim.fn.screencol()
        -- fzf-lua will interpret 1 as 100%, so send 2 instead
        if col <= 1 then col = 2 end

        local row = vim.fn.screenrow()
        if row <= 1 then row = 2 end

        require("fzf-lua")[command]({
            winopts = {
                fullscreen = false,
                col = col,
                row = row,
                width = 100,
                height = 0.5,
            },
        })
    end
end

return {
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup({
                win_options = {
                    winbar = "%{v:lua.require('oil').get_current_dir()}",
                },
                lsp_file_methods = {
                    enabled = true,
                    timeout_ms = 10000,
                    autosave_changes = true,
                },
                skip_confirm_for_simple_edits = true,
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
                desc = "Open parent directory",
            },
        },
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "mini.nvim",
        },
        -- stylua: ignore
        keys = {
            { "<space>p",           fzf("files"),                      desc = "by filename" },
            { "<space>f",           fzf("live_grep_native"),           desc = "grep" },
            { "<space>w",           fzf("grep_cword"),                 desc = "word under cursor" },
            { "<space>W",           fzf("grep_cWORD"),                 desc = "WORD under cursor" },
            { "<space>b",           fzf("buffers"),                    desc = "buffers" },
            { "<space>h",           fzf("oldfiles"),                   desc = "history" },
            { "<space>g",           fzf("git_status"),                 desc = "git status" },
            { "<space>a",           sfzf("lsp_code_actions"),          desc = "code actions" },
            { "<space>s",           fzf("lsp_document_symbols"),       desc = "symbols in document" },
            { "<space>S",           fzf("lsp_live_workspace_symbols"), desc = "symbols in workspace" },
            { "<space>r",           fzf("lsp_references"),             desc = "references to word under cursor" },
            { "<space>c",           fzf("commands"),                   desc = "nvim commands" },
            { "<space><F1>",        fzf("helptags"),                   desc = "nvim help" },
            { "<space><space>",     fzf("resume"),                     desc = "resume last fzf" },
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
                        symbol_style = 1,
                        symbol_fmt = function(s, opts) return s end,
                    },
                },
                winopts = {
                    fullscreen = true,
                    preview = {
                        flip_columns = 150,
                    },
                },
            })
            require("fzf-lua").register_ui_select()
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
        config = function() require("leap").setup() end,
        -- stylua: ignore
        keys = {
            { "s", "<Plug>(leap)",             mode = "n",          desc = "leap" },
            { "S", "<Plug>(leap-from-window)", mode = "n",          desc = "leap from window " },
            { "s", "<Plug>(leap-forward)",     mode = { "x", "o" }, desc = "leap forward" },
            { "S", "<Plug>(leap-backward)",    mode = { "x", "o" }, desc = "leap backward" },
        },
    },
}
