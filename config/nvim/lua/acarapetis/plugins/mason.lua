return {
    "williamboman/mason.nvim", dependencies = {"mini.nvim"},
    lazy = false,
    config = function()
        local packages = { "ruff", "stylua", "prettier" }

        require("mason").setup()
        local mr = require("mason-registry")
        local mnotify = require("mini.notify")
        local notify = function(msg)
            local id = mnotify.add(msg)
            vim.defer_fn(function() mnotify.remove(id) end, 2000)
        end
        for _, package_name in ipairs(packages) do
            local ok, package = pcall(mr.get_package, package_name)
            if ok then
                if not package:is_installed() then
                    notify("installing " .. package_name)
                    package:install()
                end
            else
                notify(package_name .. " not found in mason registry")
            end
        end
    end
}
