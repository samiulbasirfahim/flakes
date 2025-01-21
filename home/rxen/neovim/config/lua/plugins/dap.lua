return {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
        "williamboman/mason.nvim",
        "rcarriga/nvim-dap-ui",
        "mfussenegger/nvim-dap",
        "nvim-neotest/nvim-nio",
    },

    config = function()
        require("mason-nvim-dap").setup({
            ensure_installed = { "codelldb" },
            handlers = {},
        })

        local dap = require("dap")
        local dapui = require("dapui")
        -- UI
        dap.defaults.fallback.terminal_win_cmd = "below 10new"

        dapui.setup({
            layouts = {
                {
                    elements = {
                        "watches",
                        "scopes",
                    },
                    size = 50,
                    position = "left",
                },
                {
                    elements = {
                        "breakpoints",
                        "console",
                    },
                    size = 10,
                    position = "bottom",
                },
            },
        })

        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
        end

        require(".utility").map({
            {
                key = "<leader>dc",
                action = function()
                    dap.continue()
                end,
                mode = "n",
                desc = "[C]ontinue",
            },
            {
                key = "<leader>dt",
                action = function()
                    dap.toggle_breakpoint()
                end,
                mode = "n",
                desc = "[T]oggle breakpoint",
            },
            {
                key = "<leader>ds",
                action = function()
                    dap.terminate()
                end,
                mode = "n",
                desc = "[S]top",
            },
            {
                key = "<leader>db",
                action = function()
                    dap.step_back()
                end,
                mode = "n",
                desc = "Step [O]ut",
            },
            {
                key = "<leader>do",
                action = function()
                    dap.step_out()
                end,
                mode = "n",
                desc = "Step [O]ut",
            },
            {
                key = "<leader>dn",
                action = function()
                    dap.step_over()
                end,
                mode = "n",
                desc = "Step over",
            },
            {
                key = "<leader>di",
                action = function()
                    dap.step_into()
                end,
                mode = "n",
                desc = "Step [i]nto",
            },
            {
                key = "<leader>dr",
                action = function()
                    dap.restart()
                end,
                mode = "n",
                desc = "Restart",
            },

            {
                key = "<leader>du",
                action = function()
                    dapui.toggle()
                end,
                mode = "n",
                desc = "Toggle ui",
            },
        })
    end,
}
