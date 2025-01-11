return {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = { "c", "cpp", "lua", "rust", "python", "markdown" },
            auto_install = true,
            highlight = {
                enable = true,
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<leader>ss",
                    node_incremental = "<leader>si",
                    scope_incremental = "<leader>sc",
                    node_decremental = "<leader>sd",
                },
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["a="] = "@assignment.outer",
                        ["t="] = "@assignment.lhs",
                        ["r="] = "@assignment.rhs",
                        ["aw"] = "@word.outer",
                        ["ap"] = "@parameter.outer",
                        ["ip"] = "@parameter.inner",
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
                        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        ["ai"] = { query = "@conditional.outer", desc = "Select condition outer" },
                        ["ii"] = { query = "@conditional.inner", desc = "Select condition inner" },
                        ["al"] = { query = "@loop.outer", desc = "Select loop outer" },
                        ["il"] = { query = "@loop.inner", desc = "Select loop inner" },
                    },
                    selection_modes = {
                        ["@parameter.outer"] = "v",
                        ["@function.outer"] = "v",
                        ["@class.outer"] = "v",
                    },
                    include_surrounding_whitespace = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["<leader>sp"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["<leader>sP"] = "@parameter.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        ["]p"] = "@parameter.outer",
                        ["]af"] = "@function.outer",
                        ["]if"] = "@function.inner",
                        ["]c"] = "@class.outer",
                        ["]s"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        ["]i"] = { query = "@conditional.outer", desc = "Select condition outer" },
                        ["]l"] = { query = "@loop.outer", desc = "Select loop outer" },
                    },
                    goto_previous_start = {
                        ["[p"] = "@parameter.outer",
                        ["[af"] = "@function.outer",
                        ["[if"] = "@function.inner",
                        ["[c"] = "@class.outer",
                        ["[s"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
                        ["[i"] = { query = "@conditional.outer", desc = "Select condition outer" },
                        ["[l"] = { query = "@loop.outer", desc = "Select loop outer" },
                    },
                },
            },
        })
    end,
}
