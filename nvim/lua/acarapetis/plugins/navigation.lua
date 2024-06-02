return {
    {
        "tpope/vim-vinegar",
        lazy = false,
        keys = {
            { "_", "<Plug>VinegarVerticalSplitUp" },
        },
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
            {
                "junegunn/fzf",
                build = function()
                    vim.cmd("exec fzf#install()")
                end,
            },
        },
        keys = {
            { "<C-p>", function() require("fzf-lua").files() end },
            { "<C-f>", function() require("fzf-lua").live_grep_native() end },
            { "<C-g>", function() require("fzf-lua").grep_cword() end },
            { "<C-b>", function() require("fzf-lua").buffers() end },
            { "<BS>", function() require("fzf-lua").oldfiles() end },
        },
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle, desc="UndoTree" }
        },
    }
}
