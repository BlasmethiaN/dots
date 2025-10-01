return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "xml", "javascriptreact", "typescriptreact" },
  config = function()
    require("nvim-ts-autotag").setup()
  end,
}
