return {
    ---@type LazyPluginSpec
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
                    vim.cmd("colorscheme rose-pine")
                end,
            },

  {
    "folke/which-key.nvim",
    opts = {},
  },


  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = {
      {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
          "MunifTanjim/nui.nvim",
        },
        opts = {
            cmdline = {
                view = "cmdline",
            }
        },
      },
    },
    config = function()
        require("lualine").setup({

      options = {
        theme = "auto",
        component_separators = "",
        section_separators = "",
        icons_enabled = true,
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { "mode", color = { gui = "bold" } },
        },
        lualine_b = {
          { "branch" },
          { "diff", colored = false },
        },
        lualine_c = {
          { "filename", file_status = true },
          { "diagnostics" },
        },
        lualine_x = {
          {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
          },
          "filetype",
        },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      tabline = {},
      extensions = { "quickfix", "nvim-tree" },
        })
    end
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
