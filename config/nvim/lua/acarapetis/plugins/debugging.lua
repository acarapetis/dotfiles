return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
        },
        keys = {
            { "<Space>t", function() require("neotest").run.run({strategy = "dap"}) end, desc = "Run test" },
            { "<Space>c", function() require("dap").continue() end, mode = "n", desc = "Continue" },
            { "<Space>o", function() require("dap").step_over() end, mode = "n", desc = "Step over" },
            { "<Space>d", function() require("dap").step_into() end, mode = "n", desc = "Step into" },
            { "<Space>u", function() require("dap").step_out() end, mode = "n", desc = "Step out" },
            { "<Space>b", function() require("dap").toggle_breakpoint() end, mode = "n", desc = "Toggle breakpoint" },
            {
                "<Space>B",
                function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end,
                mode = "n",
                desc = "Log point breakpoint",
            },
            { "<Space>dr", function() require("dap").repl.open() end, mode = "n", desc = "repl" },
            { "<Space>dl", function() require("dap").run_last() end, mode = "n", desc = "Rerun" },
            { "<Space>dh", function() require("dap.ui.widgets").hover() end, mode = { "n", "v" }, desc = "Hover" },
            { "<Space>dp", function() require("dap.ui.widgets").preview() end, mode = { "n", "v" }, desc = "Preview" },
            {
                "<Space>df",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.frames)
                end,
                mode = "n",
                desc = "Frames",
            },
            {
                "<Space>ds",
                function()
                    local widgets = require("dap.ui.widgets")
                    widgets.centered_float(widgets.scopes)
                end,
                mode = "n",
                desc = "Scopes",
            },
        },
        config = function()
            require("dap-python").setup()
            require("dap-python").test_runner = "pytest"
            vim.cmd([[autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>]])
        end,
    },
    {
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
                adapters = {
                    require("neotest-python")
                }
            })
        end,
    },
}
