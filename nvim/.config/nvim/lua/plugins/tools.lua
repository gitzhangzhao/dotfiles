return {

    {
        'nvim-lua/plenary.nvim',
        event = 'VeryLazy',
    },

    {
        "nvim-telescope/telescope.nvim",
        -- event = "BufReadPre",
        keys = {
            { "<c-f>", "<cmd>lua require('telescope.builtin').find_files()<cr>", { desc = "Find files" } },
            { "<c-g>", "<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>" },
        },
        cmd = { "Telescope", "Tel" },
        opts = function()
            local actions = require("telescope.actions")
            -- local theme = require("telescope.themes")
            return {
                pickers = {
                    find_files = { hidden = false },
                    live_grep = {
                        additional_args = function(opts)
                            return { "--hidden" }
                        end,
                    },
                },
                defaults = {
                    file_ignore_patterns = {
                        "%.jpg",
                        "%.jpeg",
                        "%.webp",
                        "%.png",
                        "%.gif",
                        "%.otf",
                        "%.ttf",
                        "node_modules",
                    },
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    entry_prefix = "  ",
                    selection_strategy = "reset",
                    layout_strategy = "horizontal",
                },
            }
        end,
    },

    {
        'voldikss/vim-translator',
        keys = {{'gt', '<Plug>TranslateW'}, {'gt','<Plug>TranslateWV', mode = 'x'}},
        config = function()
            vim.g.translator_window_max_width = 0.9
            vim.g.translator_window_max_height = 0.9
        end
    },

    {
        'iamcco/markdown-preview.nvim',
        ft = 'markdown',
        build = 'cd app && yarn install',
        init = function()
            vim.g.mkdp_auto_start = 1
        end,
        config = function()
            -- vim.g.mkdp_port = '8080'
            vim.g.mkdp_open_to_the_world = 1
            vim.g.mkdp_theme = 'light'
        end
    },

    {
        'liuchengxu/vista.vim',
        event = 'VeryLazy',
        config = function()
            vim.cmd [[
            let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
            let g:vista_default_executive = 'coc'
            let g:vista_default_executive = 'coc'
            let g:vista_sidebar_open_cmd = '25vsplit'
            let g:vista_stay_on_open = 0
            let g:vista_blink = [0,0]
            let g:vista_top_level_blink = [0,0]
            ]]
            vim.keymap.set('n', '<F8>', '<CMD>Vista!!<CR>', {silent = true})
            -- close vista automatically when it's the last window open
            vim.api.nvim_create_autocmd({ "BufEnter" }, {
                pattern = { "*" },
                callback = function()
                    local is_only_one_win = vim.fn.winnr("$") == 1
                    local is_vista_open = vim.fn["vista#sidebar#IsOpen"]() == 1

                    if is_only_one_win and is_vista_open then
                        vim.cmd("silent! q!")
                    end
                end,
            })
        end
    },

    {
        'nvim-tree/nvim-tree.lua',
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
            "NvimTreeRefresh",
        },
        config = function()
            vim.g.loaded_netrwPlugin = 1
            vim.g.loaded_netrw = 1
            vim.api.nvim_create_autocmd("BufEnter", {
                group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
                pattern = "NvimTree_*",
                callback = function()
                    local layout = vim.api.nvim_call_function("winlayout", {})
                    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
                end
            })
            require('nvim-tree').setup()
        end,
        init = function()
            vim.keymap.set('n', '<F6>', '<CMD>NvimTreeToggle<CR>', { silent = true } )
        end
    },

    {
        'folke/trouble.nvim',
        keys = {{'<F7>', "<cmd>call coc#rpc#request('fillDiagnostics', [bufnr('%')])<CR><cmd>Trouble loclist<CR>"}},
        config = function()
            -- vim.api.nvim_create_autocmd('User',{
            --         pattern = 'CocNvimInit',
            --         command = "call coc#rpc#request('fillDiagnostics', [bufnr('%')])",
            --         desc = 'init loc list for trouble'
            -- })
                require('trouble').setup{
                    signs = {
                        -- icons / text used for a diagnostic
                        error = "",
                        warning = "",
                        hint = "",
                        information = "",
                        other = "﫠"
                    },
                }
            end
        },

    }
