return {
    {
        "tpope/vim-vinegar",
        lazy = false,
        keys = {
            { "_", "<Plug>VinegarVerticalSplitUp" },
            { "<S-_>", "<Plug>VinegarVerticalSplitUp" },
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
