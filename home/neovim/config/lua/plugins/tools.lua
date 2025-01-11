local leet_arg = "leetcode.nvim"

return {
    {
        "akinsho/toggleterm.nvim",
        config = function()
            local toggleterm = require("toggleterm")
            toggleterm.setup({
                size = 12,
                open_mapping = [[<c-\>]],
                shade_filetypes = {},
                run_tmux = false,
                shade_terminal = true,
                shading_factor = 1,
                start_in_insert = true,
                persist_size = true,
                direction = "horizontal",
                autochdir = true,
            })
            local keymap = vim.keymap -- for conciseness
            keymap.set("n", "<C-\\>", ":ToggleTerm<CR>")
            keymap.set("t", "<C-\\>", "<Cmd>ToggleTerm<CR>")
            vim.keymap.set("t", "<esc>", [[<C-\><C-n>]])
        end,
    },
    {
        "CRAG666/code_runner.nvim",
        event = "BufReadPre",
        keys = {
            {
                "<leader>r",
                ":RunCode<CR>",
                "n",
                desc = "Run code",
            },
        },
        config = function()
            local code_runner = require("code_runner")
            code_runner.setup({
                mode = "term",
                startinsert = true,
                filetype = {
                    python = "python3 -u",
                    typescript = "deno run",
                    rust = "cd $dir && cargo run",
                    c =
                    "cd $dir && mkdir -p .bin && cd .bin && clang --debug ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                    cpp =
                    "cd $dir && mkdir -p .bin && cd .bin && clang++ --debug ../$fileName -o $fileNameWithoutExt && ./$fileNameWithoutExt",
                },
                project = {},
            })
        end,
    },
    {
        "mg979/vim-visual-multi",
    },
    {
        "xeluxee/competitest.nvim",
        dependencies = { "muniftanjim/nui.nvim", lazy = true },
        cmd = "CompetiTest",
        keys = {
            { "<leader>ca", "<CMD>CompetiTest add_testcase<CR>",    options, desc = "CP: add testcases" },
            { "<leader>ce", "<CMD>CompetiTest edit_testcase<CR>",   options, desc = "CP: edit testcases" },
            { "<leader>cd", "<CMD>CompetiTest delete_testcase<CR>", options, desc = "CP: delete testcases" },
            { "<leader>cr", "<CMD>CompetiTest run<CR>",             options, desc = "CP: run testcases" },
            { "<leader>cp", "<CMD>CompetiTest receive problem<CR>", options, desc = "CP: download testcases" },
            { "<leader>cc", "<CMD>CompetiTest receive contest<CR>", options, desc = "CP: download contest" },
        },
        opts = {
            received_files_extension = "cpp",
            testcases_directory = "./.tests",
            compile_directory = "./.bin",
            running_directory = "./.bin",
            compile_command = {
                cpp = {
                    exec = "clang++", --[[ clang++ | g++ ]]
                    args = {
                        "-std=c++20",
                        "-pedantic",
                        "-O2",
                        "-Wall",
                        "-Wextra",
                        "-Wconversion",
                        "-Wno-sign-conversion",
                        "-Wshadow",
                        "../$(FNAME)",
                        "-o",
                        "$(FNOEXT)",
                    },
                },
                c = { exec = "clang", args = { "-Wall", "-Wextra", "-O2", "../$(FNAME)", "-o", "$(FNOEXT)" } },
            },
            run_command = {
                c = { exec = "./$(FNOEXT)" },
                cpp = { exec = "./$(FNOEXT)" },
            },
        },
    },
    {
        "kawre/leetcode.nvim",
        build = ":TSUpdate html",

        cond = vim.fn.argv()[1] == leet_arg,
        lazy = false,
        dependencies = {
            "nvim-telescope/telescope.nvim",
            "nvim-lua/plenary.nvim", -- required by telescope
            "MunifTanjim/nui.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        keys = {
            {
                "<leader>Le",
                "<cmd>Leet menu<cr>",
                desc = "focus dashboard",
            },
            {
                "<leader>Lt",
                "<cmd>Leet desc<cr>",
                desc = "toggle question description",
            },
            {
                "<leader>Ld",
                "<cmd>Leet daily<cr>",
                desc = "opens question of today",
            },
            {
                "<leader>Lc",
                "<cmd>Leet console<cr>",
                desc = "opens question console",
            },
            {
                "<leader>Li",
                "<cmd>Leet info<cr>",
                desc = "opens question information",
            },
            {
                "<leader>Ll",
                "<cmd>Leet lang<cr>",
                desc = "change question language",
            },
            {
                "<leader>Lr",
                "<cmd>Leet run<cr>",
                desc = "run question",
            },
            {
                "<leader>Ls",
                "<cmd>Leet submit<cr>",
                desc = "submit question",
            },
            {
                "<leader>Lf",
                "<cmd>Leet list<cr>",
                desc = "opens problemlist",
            },
            {
                "<leader>Lb",
                "<cmd>Leet tabs<cr>",
                desc = "opens question tabs",
            },
        },
        opts = {
            lang = "cpp",
            storage = {
                home = "$HOME/dev/leetcode",
            },
            description = {
                width = "50%",
            },
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        opts = {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = "move_selection_next",
                        ["<C-k>"] = "move_selection_previous",

                        ["<A-j>"] = "move_selection_next",
                        ["<A-k>"] = "move_selection_previous",
                    },
                },
            },
        },
    },
    {
        "lostl1ght/lazygit.nvim",
        lazy = true,
        cmd = "Lazygit",
        keys = { { "<leader>g", "<cmd>Lazygit<cr>", desc = "Git" } },
    },
    {
        "IogaMaster/neocord",
        event = "VeryLazy",
        config = function()
            require("neocord").setup()
        end,
    },
    {
        "windwp/nvim-ts-autotag",
        config = function()
            require("nvim-ts-autotag").setup()
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup()
        end,
    },
    -- {
    --     "Bekaboo/dropbar.nvim",
    --     name = "dropbar",
    --     event = { "BufReadPost", "BufNewFile" },
    --     config = function()
    --         require(".utility").map({
    --             {
    --                 key = "<leader>p",
    --                 action = function()
    --                     require("dropbar.api").pick(vim.v.count ~= 0 and vim.v.count)
    --                 end,
    --                 mode = "n",
    --                 desc = "Toggle dropdown menu",
    --             },
    --         })
    --         require("dropbar").setup({
    --             require("dropbar").setup({}),
    --         })
    --     end,
    -- },
}
