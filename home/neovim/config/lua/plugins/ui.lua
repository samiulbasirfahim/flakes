return {
    ---@type LazyPluginSpec
    {
        {
            "rose-pine/neovim",
            name = "rose-pine",
            config = function()
                require("rose-pine").setup({
                    styles = {
                        bold = false,
                        italic = true,
                        transparency = true,
                    },
                })
                vim.cmd("colorscheme rose-pine-dawn")
                vim.cmd("colorscheme rose-pine-moon")
            end,
        },
        -- {
        --     "sainnhe/gruvbox-material",
        --     priority = 1000,
        --     config = function()
        --         vim.cmd("let g:gruvbox_material_transparent_background=2")
        --         vim.cmd("let g:gruvbox_material_diagnostic_line_highlight=1")
        --         vim.cmd("let g:gruvbox_material_diagnostic_virtual_text='colored'")
        --         vim.cmd("let g:gruvbox_material_enable_italic=1")
        --
        --         vim.cmd("colorscheme gruvbox-material")
        --
        --         vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
        --         vim.api.nvim_set_hl(0, "LspInfoBorder", { link = "Normal" })
        --         vim.api.nvim_set_hl(0, "NormalFloat", { link = "Normal" })
        --     end,
        -- },
    },
    ---@type LazyPluginSpec
    {
        "j-hui/fidget.nvim",
        event = "LspAttach",
        config = function()
            local fidget = require("fidget")
            fidget.setup({
                notification = {
                    window = {
                        winblend = "0",
                    },
                },
            })
            vim.notify = fidget.notify
        end,
    },

    ---@type LazyPluginSpec
    {
        "folke/which-key.nvim",
        dependencies = {
            "echasnovski/mini.icons",
        },
        config = function()
            local wk = require("which-key")
            wk.setup({
                win = {
                    border = "single",
                },
            })
        end,
    },
}
