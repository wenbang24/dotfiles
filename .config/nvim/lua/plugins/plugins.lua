return {
    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {},
      -- stylua: ignore
      keys = {
	{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	{ "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	{ "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	{ "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	{ "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
      },
    },
     {
      "folke/which-key.nvim",
      event = "VeryLazy",
      opts = {
	-- your configuration comes here
	-- or leave it empty to use the default settings
	-- refer to the configuration section below
      },
      keys = {
	{
	  "<leader>?",
	  function()
	    require("which-key").show({ global = false })
	  end,
	  desc = "Buffer Local Keymaps (which-key)",
	},
      },
    },
    {
	"neovim/nvim-lspconfig",
	event = "BufReadPre",
	config = function() 
	    vim.api.nvim_create_autocmd('FileType', {
	      pattern = { 'c', 'cpp', 'objc', 'objcpp' },
	      callback = function(args)
		vim.lsp.start(vim.lsp.config['clangd']({}))
	      end,
	    })
	    vim.api.nvim_create_autocmd('FileType', {
		pattern = { 'go' },
		callback = function(args)
		    vim.lsp.start(vim.lsp.config['gopls']({}))
		end,
	    })
	end,
    },
    {
	"nvimdev/guard.nvim",
	dependencies = { "nvimdev/guard-collection" },
	event = "BufReadPre",
	config = function()
	    local ft = require("guard.filetype")

	    ft("c,cpp,json"):fmt("clang-format")
	end,
    },
    {'akinsho/toggleterm.nvim', version = "*", config = true},
    {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- {"3rd/image.nvim", opts = {}}, -- Optional image support in preview window: See `# Preview Mode` for more information
      {
        "s1n7ax/nvim-window-picker", -- for open_with_window_picker keymaps
        version = "2.*",
        config = function()
          require("window-picker").setup({
            filter_rules = {
              include_current_win = false,
              autoselect_one = true,
              -- filter using buffer options
              bo = {
                -- if the file type is one of following, the window will be ignored
                filetype = { "neo-tree", "neo-tree-popup", "notify" },
                -- if the buffer type is one of following, the window will be ignored
                buftype = { "terminal", "quickfix" },
              },
            },
          })
        end,
      },
    },
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")

      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "NC", -- or "" to use 'winborder' on Neovim v0.11+
        enable_git_status = true,
        enable_diagnostics = true,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- when opening files, do not use windows containing these filetypes or buftypes
        open_files_using_relative_paths = false,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "󰜌",
            provider = function(icon, node, state) -- default icon provider utilizes nvim-web-devicons if available
              if node.type == "file" or node.type == "terminal" then
                local success, web_devicons = pcall(require, "nvim-web-devicons")
                local name = node.type == "terminal" and "terminal" or node.name
                if success then
                  local devicon, hl = web_devicons.get_icon(name)
                  icon.text = devicon or icon.text
                  icon.highlight = hl or icon.highlight
                end
              end
            end,
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "󰁕", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "󰄱",
              staged = "",
              conflict = "",
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = false,
            width = 12, -- width of the column
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = false,
            width = 10, -- width of the column
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = false,
            width = 20, -- width of the column
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = false,
            width = 20, -- width of the column
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = true,
	    width = 20,
	    required_width = 80,
          },
        },
        -- A list of functions, each representing a global custom command
        -- that will be available in all sources (if not overridden in `opts[source_name].commands`)
        -- see `:h neo-tree-custom-commands-global`
        commands = {},
        window = {
          position = "left",
          width = 30,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["<esc>"] = "cancel", -- close preview or floating neo-tree window
            ["P"] = {
              "toggle_preview",
              config = {
                use_float = true,
                use_snacks_image = true,
                use_image_nvim = true,
              },
            },
            -- Read `# Preview Mode` for more information
            ["l"] = "focus_preview",
            ["S"] = "open_split",
            ["s"] = "open_vsplit",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            -- ['C'] = 'close_all_subnodes',
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            --["Z"] = "expand_all_subnodes",
            ["a"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["A"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["d"] = "delete",
            ["r"] = "rename",
            ["b"] = "rename_basename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            -- ["c"] = {
            --  "copy",
            --  config = {
            --    show_path = "none" -- "none", "relative", "absolute"
            --  }
            --}
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
            ["i"] = "show_file_details",
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              --"node_modules"
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            always_show_by_pattern = { -- uses glob style patterns
              --".env*",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = {
            enabled = false, -- This will find and focus the file in the active buffer every time
            --               -- the current file is changed while the tree is open.
          },
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["."] = "set_root",
              ["H"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["D"] = "fuzzy_finder_directory",
              ["#"] = "fuzzy_sorter", -- fuzzy sorting using the fzy algorithm
              -- ["D"] = "fuzzy_sorter_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["o"] = {
                "show_help",
                nowait = false,
                config = { title = "Order by", prefix_key = "o" },
              },
              ["on"] = { "order_by_name", nowait = false },
              ["ot"] = { "order_by_type", nowait = false },
            },
            fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
              ["<down>"] = "move_cursor_down",
              ["<C-n>"] = "move_cursor_down",
              ["<up>"] = "move_cursor_up",
              ["<C-p>"] = "move_cursor_up",
              ["<esc>"] = "close",
              ["<S-CR>"] = "close_keep_filter",
              ["<C-CR>"] = "close_clear_filter",
              ["<C-w>"] = { "<C-S-w>", raw = true },
              {
                -- normal mode mappings
                n = {
                  ["j"] = "move_cursor_down",
                  ["k"] = "move_cursor_up",
                  ["<S-CR>"] = "close_keep_filter",
                  ["<C-CR>"] = "close_clear_filter",
                  ["<esc>"] = "close",
                }
              }
            },
          },
          commands = {}, -- Add a custom command or override a global one using the same function name
        },
      })
    end,
  },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 }
}
