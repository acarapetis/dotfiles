return {
    "nvim-neotest/neotest",
    dependencies = {
        "nvim-neotest/nvim-nio",
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-python",
    },
    config = function()
        require("neotest").setup({
            consumers = {},
            status = { 
                enabled = true,
                signs = true,
                virtual_text = false,
            },
            output = { 
                enabled = true,
                open_on_run = true,
            },
            quickfix = {
                enabled = true,
                open = function()
                    require("trouble").open({ mode = "quickfix", focus = false })
                    --vim.cmd("copen")
                end,
            },
            adapters = {
                require("neotest-python")({
                    -- args can also be a function to return dynamic values
                    args = { "--log-level", "INFO" },
                    runner = "pytest",
                    -- !!EXPERIMENTAL!! Enable shelling out to `pytest` to discover test
                    -- instances for files containing a parametrize mark (default: false)
                    pytest_discover_instances = true,
                }),
            },
        })
    end,
    -- stylua: ignore
    keys = {
        {"<leader>t", "", desc = "+test..."},
        { "<leader>tt", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run File (Neotest)" },
        { "<leader>tT", function() require("neotest").run.run(vim.uv.cwd()) end, desc = "Run All Test Files (Neotest)" },
        { "<leader>tr", function() require("neotest").run.run() end, desc = "Run Nearest (Neotest)" },
        { "<leader>tl", function() require("neotest").run.run_last() end, desc = "Run Last (Neotest)" },
        { "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle Summary (Neotest)" },
        { "<leader>to", function() require("neotest").output.open({ enter = true, auto_close = true }) end, desc = "Show Output (Neotest)" },
        { "<leader>tO", function() require("neotest").output_panel.toggle() end, desc = "Toggle Output Panel (Neotest)" },
        { "<leader>tS", function() require("neotest").run.stop() end, desc = "Stop (Neotest)" },
        { "<leader>tw", function() require("neotest").watch.toggle(vim.fn.expand("%")) end, desc = "Toggle Watch (Neotest)" },
      },
}
