return {
  {
    "cocopon/iceberg.vim",
    lazy = false, -- load on startup
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- load the color scheme here
      vim.cmd([[colorscheme iceberg]])
    end,
  },
}
