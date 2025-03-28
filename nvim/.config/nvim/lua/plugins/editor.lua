return {

    {
        'abecodes/tabout.nvim',
        event = 'InsertEnter',
        config = function()
            require('tabout').setup {
                tabkey = '<c-l>',
                backwards_tabkey = '<c-h>',
                tabouts = {
                    {open = "'", close = "'"},
                    {open = '"', close = '"'},
                    {open = '`', close = '`'},
                    {open = '(', close = ')'},
                    {open = '[', close = ']'},
                    {open = '{', close = '}'},
                }
            }
        end,
    },

    {
        'numToStr/Comment.nvim',
        keys = { 'gcc', {'gc', mode = 'x'}, 'gbc', {'gb', mode = 'x'}},
        config = true
    },

    {
        'yamatsum/nvim-cursorline',
	event = 'BufReadPost',
        config = function ()
            require('nvim-cursorline').setup {
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                }
            }
        end
    },

    {
        'karb94/neoscroll.nvim',
        keys = {'<C-k>', '<C-j>', {'<C-j>', mode = 'x'}, {'<C-k>', mode = 'x'}},
        config = function()
            require('neoscroll').setup({
                -- All these keys will be mapped to their corresponding default scrolling animation
                mappings = {},
                hide_cursor = true,          -- Hide cursor while scrolling
                stop_eof = true,             -- Stop at <EOF> when scrolling downwards
                respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
                cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
                easing_function = nil,       -- Default easing function
                pre_hook = nil,              -- Function to run before the scrolling animation starts
                post_hook = nil,             -- Function to run after the scrolling animation ends
                performance_mode = false,    -- Disable "Performance Mode" on all buffers.
            })
            neoscroll = require('neoscroll')
            local keymap = {
                ["<C-k>"] = function() neoscroll.ctrl_u({ duration = 250 }) end;
                ["<C-j>"] = function() neoscroll.ctrl_d({ duration = 250 }) end;
            }
            local modes = { 'n', 'v', 'x' }
            for key, func in pairs(keymap) do
                vim.keymap.set(modes, key, func)
            end
        end
    },

        {
            'nvim-treesitter/nvim-treesitter',
            lazy = false,
            build = ':TSUpdate',
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = {"vim", "lua", "c", "make", "markdown", "json", "diff", "cpp", "bash", "verilog", "latex" },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<CR>',
                        node_incremental = '<CR>',
                        node_decremental = '<BS>',
                        scope_incremental = '<TAB>',
                    }
                },
                matchup = {
                    enable = true
                },
                textobjects = {
                    swap = {
                        enable = true,
                        swap_next = {
                            ["cx"] = "@parameter.inner",
                        },
                        swap_previous = {
                            ["cX"] = "@parameter.inner",
                        },
                    },
                },
            }
        end
    },

    {
        'andymass/vim-matchup',
        event = 'BufReadPost',
        config = function()
            vim.g.matchup_matchparen_offscreen = {}
        end

    },

    {
        'nvim-treesitter/nvim-treesitter-context',
        event = 'BufReadPre',
        config = true
    },

    --  close this plugin to avoid the bug of #47
    -- {
    --     'kevinhwang91/nvim-ufo',
    --     -- event = 'BufRead',
    --     lazy = false,
    --     dependencies = 'kevinhwang91/promise-async',
    --     config = function()
    --         local handler = function(virtText, lnum, endLnum, width, truncate)
    --             local newVirtText = {}
    --             local suffix = ('  %d '):format(endLnum - lnum)
    --             local sufWidth = vim.fn.strdisplaywidth(suffix)
    --             local targetWidth = width - sufWidth
    --             local curWidth = 0
    --             for _, chunk in ipairs(virtText) do
    --                 local chunkText = chunk[1]
    --                 local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --                 if targetWidth > curWidth + chunkWidth then
    --                     table.insert(newVirtText, chunk)
    --                 else
    --                     chunkText = truncate(chunkText, targetWidth - curWidth)
    --                     local hlGroup = chunk[2]
    --                     table.insert(newVirtText, {chunkText, hlGroup})
    --                     chunkWidth = vim.fn.strdisplaywidth(chunkText)
    --                     -- str width returned from truncate() may less than 2nd argument, need padding
    --                     if curWidth + chunkWidth < targetWidth then
    --                         suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
    --                     end
    --                     break
    --                 end
    --                 curWidth = curWidth + chunkWidth
    --             end
    --             table.insert(newVirtText, {suffix, 'MoreMsg'})
    --             return newVirtText
    --         end
    --         -- global handler
    --         -- `handler` is the 2nd parameter of `setFoldVirtTextHandler`,
    --         -- check out `./lua/ufo.lua` and search `setFoldVirtTextHandler` for detail.
    --         require('ufo').setup({
    --             fold_virt_text_handler = handler
    --         })
    --     end
    -- },

    {
        'anuvyklack/pretty-fold.nvim',
        event = 'VeryLazy',
        config = function()
            require('pretty-fold').setup({})
        end
    },

    {
        'phaazon/hop.nvim',
        branch = 'v2',
        keys = 'f',
        config = function()
            require('hop').setup{keys = "etovxqpdygfblzhckisuran"}
            local function map(mode, l, r, opts)
                opts = opts or {}
                vim.keymap.set(mode, l, r, opts)
            end
            map("n", "fj",  ":HopWordAC<cr>", {silent = true})
            map("n", "fk",  ":HopWordBC<cr>", {silent = true})
            map("n", "fl", ":HopWordCurrentLineAC<cr>", {silent = true})
            map("n", "fh", ":HopWordCurrentLineBC<cr>", {silent = true})
        end
    },

    {
        'tpope/vim-surround',
        event = 'VeryLazy',
        config = function()
            vim.cmd [[
            vmap " S"
            vmap ] S]
            vmap [ S]
            vmap ' S'
            vmap > S>
            vmap < S>
            vmap ) S)
            vmap ( S)
            vmap } S}
            vmap { S}
            vmap ` S`
            ]]
        end
    },

    {
        'nat-418/boole.nvim',
        keys = { '<c-a>', '<c-x>' },
        config = function()
            require('boole').setup({
                mappings = {
                    increment = '<C-a>',
                    decrement = '<C-x>'
                },
                -- User defined loops
                additions = {
                    {'Foo', 'Bar'},
                    {'tic', 'tac', 'toe'}
                },
                allow_caps_additions = {
                    {'enable', 'disable'}
                    -- enable → disable
                    -- Enable → Disable
                    -- ENABLE → DISABLE
                }
            })
        end
    },

    {
        'tpope/vim-repeat',
        keys = '.',
        config = function()
            vim.cmd [[silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)]]
        end
    },

    {
        'junegunn/vim-easy-align',
        event = 'VeryLazy',
        config = function()
            vim.keymap.set('x', 'ga', '<Plug>(EasyAlign)', { silent = true, noremap = true } )
            vim.keymap.set('n', 'ga', '<Plug>(EasyAlign)', { silent = true, noremap = true } )
        end

    },

    {
        'mg979/vim-visual-multi',
        branch = 'master',
        keys = '<c-n>'
    },

    {
        'h-hg/fcitx.nvim',
        event = 'InsertEnter'
    },

    {
        'alpertuna/vim-header',
        event = 'CmdlineEnter',
        config = function()
            vim.g.header_auto_add_header = 0
            vim.g.header_field_author = 'zhangzhao'
            vim.g.header_field_author_email = 'zhangzhao@ihep.ac.cn'
        end
    },

    {
        'romainl/vim-cool',
        event = { 'CursorMoved', 'InsertEnter' },
    },

    {
        'kana/vim-textobj-user',
        event = 'VeryLazy',
        dependencies = {
            {'glts/vim-textobj-comment'},
            {'kana/vim-textobj-line'},
            { 'tommcdo/vim-exchange' },
            {'sgur/vim-textobj-parameter'}
        }
    },

    {
        'gbprod/yanky.nvim',
        keys = {'p','P','y'},
        config = function()
            local opts = {
                noremap = true,
                silent = true,
            }
            vim.keymap.set({"n","x"}, "p", "<Plug>(YankyPutAfter)", opts)
            vim.keymap.set({"n","x"}, "P", "<Plug>(YankyPutBefore)", opts)
            vim.keymap.set("n", "<s-w>", "<Plug>(YankyCycleForward)", opts)
            vim.keymap.set("n", "<s-q>", "<Plug>(YankyCycleBackward)", opts)
            require('yanky').setup()
        end
    },

    {
        'fedepujol/move.nvim',
        keys = {'K', 'J', 'H', 'L', {'K', mode = 'x'}, {'J', mode = 'x'}, {'H', mode = 'x'}, {'L', mode = 'x'}},
        config = function()
            local opts = { noremap = true, silent = true }
            -- Normal-mode commands
            vim.keymap.set('n', 'J', ':MoveLine(1)<CR>', opts)
            vim.keymap.set('n', 'K', ':MoveLine(-1)<CR>', opts)
            vim.keymap.set('n', 'H', ':MoveHChar(-1)<CR>', opts)
            vim.keymap.set('n', 'L', ':MoveHChar(1)<CR>', opts)

            -- Visual-mode commands
            vim.keymap.set('v', 'J', ':MoveBlock(1)<CR>', opts)
            vim.keymap.set('v', 'K', ':MoveBlock(-1)<CR>', opts)
            vim.keymap.set('v', 'H', ':MoveHBlock(-1)<CR>', opts)
            vim.keymap.set('v', 'L', ':MoveHBlock(1)<CR>', opts)

            require('move').setup()
        end
    },

    {
        'lambdalisue/suda.vim',
        lazy = false,
        init = function()
            vim.g.suda_smart_edit = 1
        end
    },

    {
        'Wansmer/treesj',
        keys = {{ 'gh', '<cmd>TSJToggle<CR>' }},
        config = function()
                local tsj = require('treesj')
                local langs = {--[[ configuration for languages ]]}
                tsj.setup({
                    -- Use default keymaps
                    use_default_keymaps = false,
                    -- Node with syntax error will not be formatted
                    check_syntax_error = true,
                    -- If line after join will be longer than max value,
                    -- node will not be formatted
                    max_join_length = 240,
                    cursor_behavior = 'hold',
                    -- Notify about possible problems or not
                    notify = true,
                    langs = langs,
                    -- Use `dot` for repeat action
                    dot_repeat = true,
                })
        end,
    }


}
