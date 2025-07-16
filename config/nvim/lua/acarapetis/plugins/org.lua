return {
    {
        "bngarren/checkmate.nvim",
        ft = "markdown",
        opts = {
            keys = {
                ["cx"] = {
                    rhs = "<cmd>Checkmate toggle<CR>",
                    desc = "Toggle todo item",
                    modes = { "n", "v" },
                },
                ["yx"] = {
                    rhs = "<cmd>Checkmate create<CR>",
                    desc = "Create todo item",
                    modes = { "n", "v" },
                },
                ["<leader>tR"] = {
                    rhs = "<cmd>Checkmate remove_all_metadata<CR>",
                    desc = "Remove all metadata from a todo item",
                    modes = { "n", "v" },
                },
                ["<leader>ta"] = {
                    rhs = "<cmd>Checkmate archive<CR>",
                    desc = "Archive checked/completed todo items (move to bottom section)",
                    modes = { "n" },
                },
                ["<leader>tv"] = {
                    rhs = "<cmd>Checkmate metadata select_value<CR>",
                    desc = "Update the value of a metadata tag under the cursor",
                    modes = { "n" },
                },
                ["<leader>t]"] = {
                    rhs = "<cmd>Checkmate metadata jump_next<CR>",
                    desc = "Move cursor to next metadata tag",
                    modes = { "n" },
                },
                ["<leader>t["] = {
                    rhs = "<cmd>Checkmate metadata jump_previous<CR>",
                    desc = "Move cursor to previous metadata tag",
                    modes = { "n" },
                },
            },
        },
    },
}
