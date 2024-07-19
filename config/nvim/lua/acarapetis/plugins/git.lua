return {
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>G", ":G",            desc = "Git command" },
            { "<leader>g", vim.cmd.G,       desc = "Git status" },
            { "gb",        vim.cmd.GBrowse, desc = "View on GitHub/Bitbucket" },
        },
        config = function()
            vim.api.nvim_create_user_command(
                "Browse",
                function(opts) vim.fn.system({ "xdg-open", opts.fargs[1] }) end,
                { nargs = 1 }
            )
        end,
    },
    "tpope/vim-rhubarb",
    "tommcdo/vim-fubitive",
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = 'right_align',
                    delay = 0,
                    ignore_whitespace = true,
                    virt_text_priority = 100,
                },
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end)

                    map('n', '[h', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end)

                    -- Actions
                    map('n', '<leader>-', gitsigns.stage_hunk, { desc = "Stage hunk" })
                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = "Stage hunk" })
                    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = "Reset hunk" })
                    map('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "Stage selected lines" })
                    map('v', '<leader>hX', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
                        { desc = "Reset selected lines" })
                    map('n', '<leader>h%s', gitsigns.stage_buffer, { desc = "Stage whole buffer" })
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk, { desc = "Unstage hunk" })
                    map('n', '<leader>h%X', gitsigns.reset_buffer, { desc = "Reset entire buffer" })
                    map('n', '<Space>', gitsigns.preview_hunk, { desc = "Preview hunk" })
                    map('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = "Blame hunk" })
                    map('n', '<leader>b', gitsigns.toggle_current_line_blame, { desc = "Toggle blame" })
                    map('n', '<leader>hd', gitsigns.diffthis, { desc = "Show current diff" })
                    map('n', '<leader>hD', function() gitsigns.diffthis('~') end, { desc = "Show last diff" })
                    map(
                        'n',
                        '<leader>hl',
                        function()
                            gitsigns.toggle_linehl()
                            gitsigns.toggle_deleted()
                        end,
                        { desc = "Toggle full highlighting" }
                    )

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end
            })
        end,
        lazy = false,
    }
}
