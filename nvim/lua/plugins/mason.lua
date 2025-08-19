return {
    "mason-org/mason-lspconfig.nvim",
    opts = {
        ensure_installed = { "pylsp" },
    },
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
    },
}
