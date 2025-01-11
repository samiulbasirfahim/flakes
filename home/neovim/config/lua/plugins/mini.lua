local function confirm_discard_changes(all_buffers)
    local buf_list = all_buffers == false and { 0 } or vim.api.nvim_list_bufs()
    local unsaved = vim.tbl_filter(function(buf_id)
        return vim.bo[buf_id].modified and vim.bo[buf_id].buflisted
    end, buf_list)

    if #unsaved == 0 then
        return true
    end

    for _, buf_id in ipairs(unsaved) do
        local name = vim.api.nvim_buf_get_name(buf_id)
        local result = vim.fn.confirm(
            string.format('Save changes to "%s"?', name ~= "" and vim.fn.fnamemodify(name, ":~:.") or "Untitled"),
            "&Yes\n&No\n&Cancel",
            1,
            "Question"
        )

        if result == 1 then
            if buf_id ~= 0 then
                vim.cmd("buffer " .. buf_id)
            end
            vim.cmd("update")
        elseif result == 0 or result == 3 then
            return false
        end
    end

    return true
end

return {
    ---@type LazyPkgSpec
    {
        "echasnovski/mini.tabline",
        config = function()
            require("mini.tabline").setup()
        end,
    },
    {
        "echasnovski/mini.sessions",
        config = function()
            local MiniSessions = require("mini.sessions")
            MiniSessions.setup({})
            vim.keymap.set("n", "<leader>sd", function()
                MiniSessions.select("delete")
            end, { desc = "Delete session" })
            vim.keymap.set("n", "<leader>sf", function()
                MiniSessions.select()
            end, { desc = "Find session" })
            vim.keymap.set("n", "<leader>sw", function()
                vim.ui.input({
                    prompt = "Session Name: ",
                    default = vim.v.this_session ~= "" and vim.v.this_session
                        or vim.fn.fnamemodify(vim.fn.getcwd(), ":t"),
                }, function(input)
                    if input ~= nil then
                        MiniSessions.write(input, { force = true })
                    end
                end)
            end, { desc = "Save session" })
            vim.keymap.set("n", "<leader>sx", function()
                if confirm_discard_changes() then
                    vim.v.this_session = ""
                    vim.cmd("%bwipeout!")
                end
            end, { desc = "Clear current session" })
        end,
    },

    {
        "echasnovski/mini.icons",
        init = function()
            package.preload["nvim-web-devicons"] = function()
                package.loaded["nvim-web-devicons"] = {}
                require("mini.icons").mock_nvim_web_devicons()
                return package.loaded["nvim-web-devicons"]
            end
        end,
        config = function()
            require("mini.icons").setup({
                extension = {
                    h = { glyph = "", hl = "MiniIconsCyan" },
                    norg = { glyph = "", hl = "MiniIconsCyan" },
                },
            })
        end,
    },
    {
        "echasnovski/mini.bufremove",
        config = function()
            require("mini.bufremove").setup({})
            vim.keymap.set("n", "<leader>q", function()
                if confirm_discard_changes(false) then
                    require("mini.bufremove").delete(0, true)
                end
            end, { desc = "Close buffer" })
        end,
    },
    {
        "echasnovski/mini.surround",
        config = function()
            require("mini.surround").setup()
        end,
    },
    ---@type LazyPluginSpec
    {
        "echasnovski/mini.pick",
        dependencies = { "echasnovski/mini.extra", "echasnovski/mini.fuzzy" },
        config = function()
            local minipick = require("mini.pick")
            local miniextra = require("mini.extra")
            -- local minivisits = require("mini.visits")
            local builtin = minipick.builtin

            vim.ui.select = minipick.ui_select

            miniextra.setup()
            require("mini.fuzzy").setup()

            minipick.setup({
                mappings = {
                    move_down = "<C-j>",
                    move_start = "<C-g>",
                    move_up = "<C-k>",
                },
            })

            require(".utility").map({
                {
                    mode = "n",
                    key = "<leader>ff",
                    action = function()
                        builtin.files({ tool = "rg" })
                    end,
                    desc = "Find [f]iles",
                },
                {
                    mode = "n",
                    key = "<leader>fr",
                    action = function()
                        builtin.resume()
                    end,
                    desc = "[R]esume finding",
                },
                {
                    mode = "n",
                    key = "<leader>fg",
                    action = function()
                        builtin.grep_live({ tool = "rg" })
                    end,
                    desc = "Live [g]rep",
                },
                {
                    mode = "n",
                    key = "<leader>fb",
                    action = function()
                        builtin.buffers()
                    end,
                    desc = "Find [b]uffer",
                },
                {
                    mode = "n",
                    key = "<leader>fh",
                    action = function()
                        builtin.help()
                    end,
                    desc = "Find [h]elp",
                },
                {
                    mode = "n",
                    key = "<leader>fw",
                    action = function()
                        miniextra.pickers.buf_lines()
                    end,
                    desc = "Find [w]ord",
                },

                {
                    mode = "n",
                    key = "<leader>fk",
                    action = function()
                        miniextra.pickers.keymaps()
                    end,
                    desc = "[K]eymaps",
                },

                {
                    mode = "n",
                    key = "<leader>fld",
                    action = function()
                        miniextra.pickers.lsp({ scope = "declaration" })
                    end,
                    desc = "[D]eclaration",
                },

                {
                    mode = "n",
                    key = "<leader>flr",
                    action = function()
                        miniextra.pickers.lsp({ scope = "references" })
                    end,
                    desc = "[R]eferences",
                },

                {
                    mode = "n",
                    key = "<leader>fli",
                    action = function()
                        miniextra.pickers.lsp({ scope = "implementation" })
                    end,
                    desc = "[I]mplementation",
                },

                {
                    mode = "n",
                    key = "<leader>fls",
                    action = function()
                        miniextra.pickers.lsp({ scope = "document_symbol" })
                    end,
                    desc = "[S]symbol",
                },

                {
                    mode = "n",
                    key = "<leader>flt",
                    action = function()
                        miniextra.pickers.lsp({ scope = "type_definition" })
                    end,
                    desc = "[T]ype definition",
                },

                {
                    mode = "n",
                    key = "<leader>flw",
                    action = function()
                        miniextra.pickers.lsp({ scope = "workspace_symbol" })
                    end,
                    desc = "[W]orkspace symbol",
                },

                {
                    mode = "n",
                    key = "<leader>flD",
                    action = function()
                        miniextra.pickers.lsp({ scope = "definition" })
                    end,
                    desc = "[D]efinition",
                },
                {
                    mode = "n",
                    key = "<leader>fd",
                    action = function()
                        miniextra.pickers.diagnostic()
                    end,
                    desc = "[D]iagnostics",
                },
                {
                    mode = "n",
                    key = "<leader>fo",
                    action = function()
                        miniextra.pickers.oldfiles()
                    end,
                    desc = "Find [o]oldfiles",
                },

                {
                    mode = "n",
                    key = "<leader>fe",
                    action = function()
                        miniextra.pickers.explorer()
                    end,
                    desc = "[E]xplorer",
                },
                {
                    mode = "n",
                    key = "<leader>fc",
                    action = function()
                        miniextra.pickers.git_commits()
                    end,
                    desc = "Git [c]ommits",
                },
            })
        end,
    },
    {
        "echasnovski/mini.indentscope",
        config = function()
            require("mini.indentscope").setup({
                draw = {
                    delay = 0,
                    animation = function()
                        return 0
                    end,
                },
                options = { try_as_border = true, border = "both", indent_at_cursor = true },
            })
        end,
    },
    {
        "echasnovski/mini.comment",
        config = function()
            require("mini.comment").setup()
        end,
    },
    {
        "echasnovski/mini.files",
        config = function()
            local MiniFiles = require("mini.files")

            MiniFiles.setup({
                mappings = {
                    close = "q",
                    go_in_plus = "l",
                    go_out = "h",
                    go_out_plus = "",
                    reset = "<bs>",
                    reveal_cwd = "@",
                    show_help = "g?",
                    synchronize = "<c-s>",
                    trim_left = "<",
                    trim_right = ">",
                },
                windows = {
                    preview = false,
                    width_focus = 25,
                    width_preview = 30,
                    width_nofocus = 20,
                },
            })

            local function dynamic_open(path)
                MiniFiles.open(path, true, {})
            end

            vim.keymap.set("n", "<leader>e", function()
                if not MiniFiles.close() then
                    dynamic_open(".")
                end
            end, { desc = "Open file browser" })
            vim.keymap.set("n", "-", function()
                dynamic_open(vim.api.nvim_buf_get_name(0))
                MiniFiles.reveal_cwd()
            end, { desc = "Open file browser" })

            local files_set_cwd = function()
                local cur_entry_path = MiniFiles.get_fs_entry().path
                local cur_directory = vim.fs.dirname(cur_entry_path)
                if vim.fn.chdir(cur_directory) ~= "" then
                    print("Current directory set to " .. cur_directory)
                else
                    print("Unable to set current directory")
                end
            end

            local minifiles_triggers = vim.api.nvim_create_augroup("MiniFilesMappings", { clear = true })

            vim.api.nvim_create_autocmd("User", {
                group = minifiles_triggers,
                pattern = "MiniFilesBufferCreate",
                callback = function(args)
                    local buf_id = args.data.buf_id
                    vim.keymap.set("n", "g.", files_set_cwd, { buffer = buf_id, desc = "Set CWD" })
                end,
            })
        end,
    },
}
