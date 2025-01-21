return {
    ---@type LazyPluginSpec
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            {
                "jay-babu/mason-null-ls.nvim",
                dependencies = {
                    "williamboman/mason.nvim",
                    "nvimtools/none-ls.nvim",
                    "nvim-lua/plenary.nvim",
                },
                config = function()
                    local null_ls = require("null-ls")

                    require("null-ls").setup({
                        sources = {
                            -- null_ls.builtins.diagnostics.cppcheck,
null_ls.builtins.formatting.clang_format.with({
                                    filetypes = { "c", "cpp", "cc", "hpp", "h" },
                                    extra_args = {
                                        "--style",
                                        "{BasedOnStyle: llvm, IndentWidth: 4}",
                                    },
                                })
                        },
                    })
                    local mason = require("mason-null-ls")
                    require("mason-null-ls").setup({
                        ensure_installed = { "stylua", 
                            "shfmt",
                            -- "prettierd"
                        },
                        automatic_installation = false,

                        handlers = {
                            mason.default_setup,

                            clang_format = function()
                                null_ls.register(null_ls.builtins.formatting.clang_format.with({
                                    filetypes = { "c", "cpp", "cc", "hpp", "h" },
                                    extra_args = {
                                        "--style",
                                        "{BasedOnStyle: llvm, IndentWidth: 4}",
                                    },
                                }))
                            end,
                            shfmt = function()
                                null_ls.register(null_ls.builtins.formatting.shfmt.with({
                                    extra_args = {
                                        "--indent",
                                        "4",
                                    },
                                }))
                            end,
                        },
                    })
                end,
            },
        },
        config = function()
            local lspconfig = require("lspconfig")

            local M = {}

            M.on_attach = function(client, _)
                if client.name == "clangd" then
                    client.server_capabilities.documentFormattingProvider = false -- 0.8 and later
                end
                if vim.fn.has("nvim-0.10") == 1 then
                    vim.lsp.inlay_hint.enable()
                end
            end

            M.capabilities = vim.lsp.protocol.make_client_capabilities()
            M.capabilities = require("cmp_nvim_lsp").default_capabilities(M.capabilities)

            require("lspconfig").clangd.setup(
            { 
                on_attach = M.on_attach, 
                capabilities = M.capabilities,
            }
            )


require("lspconfig").nixd.setup({
  cmd = { "nixd" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixpkgs-fmt" }, -- or nixfmt or nixpkgs-fmt
      },
      -- options = {
        -- nixos = {
        --     expr = '(builtins.getFlake "/nix/persist/home/rxen/dev/flakes/").nixosConfigurations.CONFIGNAME.options',
        -- },
        -- home_manager = {
        --     expr = '(builtins.getFlake "/nix/persist/home/rxen/dev/flakes/").homeConfigurations.CONFIGNAME.options',
        -- },
      -- },
    },
  },
})

            require("mason").setup({})
            require("mason-lspconfig").setup({
                automatic_installation = true,
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                },
            })

            require("mason-lspconfig").setup_handlers({
                function(server)
                    lspconfig[server].setup({
                        on_attach = M.on_attach,
                        capabilities = M.capabilities,
                    })
                end,
            })

            lspconfig.lua_ls.setup({
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                                [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                            },
                        },
                    },
                },
            })

            local signs = { Error = "✘", Warn = "󱡃", Hint = "󱐮", Info = "󱓔" }
            -- local signs = { Error = "✘", Warn = "󱡃", Hint = ">>", Info = ">>" }

            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                update_in_insert = true,
                underline = true,
                severity_sort = false,
                float = {
                    border = "single",
                    source = true,
                    header = "",
                    prefix = "",
                },
            })

            require(".utility").map({
                {
                    key = "<leader>lf",
                    action = function()
                        vim.lsp.buf.format()
                    end,
                    mode = "n",
                    desc = "[F]format file",
                },
                {
                    key = "<leader>ls",
                    action = function()
                        vim.lsp.buf.signature_help()
                    end,
                    mode = "n",
                    desc = "[S]ignature help",
                },
                {
                    key = "<leader>lt",
                    action = function()
                        vim.lsp.buf.type_definition()
                    end,
                    mode = "n",
                    desc = "[T]ype defination",
                },
                {
                    key = "<leader>la",
                    action = function()
                        vim.lsp.buf.code_action()
                    end,
                    mode = "n",
                    desc = "Code [a]ction",
                },
                {
                    key = "<leader>ld",
                    action = function()
                        vim.lsp.buf.definition()
                    end,
                    mode = "n",
                    desc = "Go to [d]efinition",
                },
                {
                    key = "<leader>lD",
                    action = function()
                        vim.lsp.buf.declaration()
                    end,
                    mode = "n",
                    desc = "Go to [d]eclaration",
                },
                {
                    key = "<leader>lR",
                    action = function()
                        vim.lsp.buf.references()
                    end,
                    mode = "n",
                    desc = "Go to [r]eferences",
                },
                {
                    key = "<leader>lr",
                    action = function()
                        vim.lsp.buf.rename()
                    end,
                    mode = "n",
                    desc = "[R]ename",
                },
                {
                    key = "<leader>ln",
                    action = function()
                        vim.diagnostic.goto_next()
                    end,
                    mode = "n",
                    desc = "Go to [n]ext diagnostic",
                },
                {
                    key = "<leader>lp",
                    action = function()
                        vim.diagnostic.goto_prev()
                    end,
                    mode = "n",
                    desc = "Go to [p]rev diagnostic",
                },
            })

            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
                border = "single",
            })

            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
                border = "single",
            })

            vim.o.updatetime = 250
            vim.cmd([[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]])
        end,
    },
}
