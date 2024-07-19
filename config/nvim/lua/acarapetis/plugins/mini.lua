return {
    {
        "echasnovski/mini.nvim",
        config = function()
            require("mini.ai").setup()
            require("mini.notify").setup()
            require("mini.icons").setup()
            require("mini.icons").mock_nvim_web_devicons()
            require("mini.pairs").setup({
                modes = { insert = true, command = true, terminal = false },
            })
            require("mini.surround").setup({
                mappings = {
                    add = "sa",
                    delete = "sd",
                    find = "",
                    find_left = "",
                    highlight = "",
                    replace = "sc",
                    update_n_lines = "",
                },
                search_method = "cover_or_next",
            })
            local miniclue = require("mini.clue")
            miniclue.setup({
                triggers = {
                    -- Leader triggers
                    { mode = 'n', keys = '<Leader>' },
                    { mode = 'x', keys = '<Leader>' },

                    -- Built-in completion
                    { mode = 'i', keys = '<C-x>' },

                    -- `g` key
                    { mode = 'n', keys = 'g' },
                    { mode = 'x', keys = 'g' },

                    -- Marks
                    { mode = 'n', keys = "'" },
                    { mode = 'n', keys = '`' },
                    { mode = 'x', keys = "'" },
                    { mode = 'x', keys = '`' },

                    -- Registers
                    { mode = 'n', keys = '"' },
                    { mode = 'x', keys = '"' },
                    { mode = 'i', keys = '<C-r>' },
                    { mode = 'c', keys = '<C-r>' },

                    -- Window commands
                    { mode = 'n', keys = '<C-w>' },

                    -- `z` key
                    { mode = 'n', keys = 'z' },
                    { mode = 'x', keys = 'z' },

                    { mode = "n", keys = "]" },
                    { mode = "n", keys = "[" },
                },

                clues = {
                    -- Enhance this by adding descriptions for <Leader> mapping groups
                    miniclue.gen_clues.builtin_completion(),
                    miniclue.gen_clues.g(),
                    miniclue.gen_clues.marks(),
                    miniclue.gen_clues.registers(),
                    miniclue.gen_clues.windows(),
                    miniclue.gen_clues.z(),
                    { mode="n", keys="<leader>f", desc = "+find..." },
                    { mode="n", keys="<leader>F", desc = "+format..." },
                    { mode="n", keys="<leader>r", desc = "+refactor..." },
                    { mode="n", keys="<leader>v", desc = "+lsp..." },
                    { mode="n", keys="<leader>x", desc = "+trouble..." },
                    { mode="n", keys="<leader>h", desc = "+hunks..." },
                },

                window = {
                    delay = 200,
                    config = {
                        anchor = "SW",
                        row = "auto",
                        col = "auto",
                        width = "auto",
                    }
                }
            })
        end
    }
}
