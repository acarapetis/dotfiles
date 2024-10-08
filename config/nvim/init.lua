vim.opt.compatible = false

-- begin lazy.nvim bootstrap
-- See lua/plugins.lua for the plugin spec
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- end lazy.nvim bootstrap

require("lazy").setup("acarapetis.plugins")
require("acarapetis.bindings")
require("acarapetis.vimconfig")
require("acarapetis.fug")
require("acarapetis.make")
