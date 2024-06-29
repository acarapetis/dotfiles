return {
    {
        "stevearc/oil.nvim",
        config = function()
            require("oil").setup()
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
            { "<C-p>", function() require("fzf-lua").files() end },
            { "<C-f>", function() require("fzf-lua").live_grep_native() end },
            { "<C-g>", function() require("fzf-lua").grep_cword() end },
            { "<C-b>", function() require("fzf-lua").buffers() end },
            { "<BS>", function() require("fzf-lua").oldfiles() end },
        },
        opts = {
            fzf_opts = {["--layout"] = "default"},
            oldfiles = {
                include_current_session = true,
            }
        },
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc="UndoTree" }
        },
    }
}
