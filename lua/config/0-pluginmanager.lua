-- ========================================================================== --
-- ==                               PLUGINS                                == --
-- ========================================================================== --

local lazy = {}

function lazy.install(path)
	if not vim.loop.fs_stat(path) then
		print('Installing lazy.nvim....')
		vim.fn.system({
			'git',
			'clone',
			'--filter=blob:none',
			'https://github.com/folke/lazy.nvim.git',
			'--branch=stable', -- latest stable release
			path,
		})
	end
end

function lazy.setup(plugins)
	-- You can "comment out" the line below after lazy.nvim is installed
	lazy.install(lazy.path)

	vim.opt.rtp:prepend(lazy.path)
	require('lazy').setup(plugins, lazy.opts)
end

lazy.path = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
lazy.opts = {}

lazy.setup({
	-- statusline but lua
	{'nvim-lualine/lualine.nvim'},

	-- Highlight, edit, and navigate code
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

	-- undotree
	{'mbbill/undotree'},

	-- neodev api 
	{ "folke/neodev.nvim", opts = {} },

	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim', opts = {} },

	-- Git
	{'tpope/vim-fugitive'},
	-- Adds git related signs to the gutter, as well as utilities for managing changes
	{
		'lewis6991/gitsigns.nvim',
		opts = {
			signs = {
				add = { text = '+' },
				change = { text = '~' },
				delete = { text = '_' },
				topdelete = { text = '‾' },
				changedelete = { text = '~' },
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

				-- don't override the built-in and fugitive keymaps
				local gs = package.loaded.gitsigns
				vim.keymap.set({'n', 'v'}, ']c', function()
					if vim.wo.diff then return ']c' end
					vim.schedule(function() gs.next_hunk() end)
					return '<Ignore>'
					end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
				vim.keymap.set({'n', 'v'}, '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
					end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
			end,
		},
	},

	{
		'dinhhuy258/git.nvim',
		config = function ()
			require("git").setup()
		end,
	},

	-- commenting out lines
	{
		"numToStr/Comment.nvim",
		config = function()
			require('Comment').setup({
				opleader = {
					---Block-comment keymap
					block = '<Nop>',
				},
			}) 
		end
	},

	-- file explorer
	{
		"nvim-tree/nvim-tree.lua",
		-- version = "*",
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	-- telescope
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.3',
		dependencies = { 'nvim-lua/plenary.nvim' },
	},

	-- save my last cursor position
	{ "ethanholz/nvim-lastplace" },

	{
		"fatih/vim-go",
		config = function ()
			-- we disable most of these features because treesitter and nvim-lsp
			-- take care of it
			vim.g['go_gopls_enabled'] = 0
			vim.g['go_code_completion_enabled'] = 0
			vim.g['go_fmt_autosave'] = 0
			vim.g['go_imports_autosave'] = 0
			vim.g['go_mod_fmt_autosave'] = 0
			vim.g['go_doc_keywordprg_enabled'] = 0
			vim.g['go_def_mapping_enabled'] = 0
			vim.g['go_textobj_enabled'] = 0
			vim.g['go_list_type'] = 'quickfix'
		end,
	},

	-- LSP
	{
		{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},

		--- Uncomment these if you want to manage LSP servers from neovim
		{'williamboman/mason.nvim'},
		{'williamboman/mason-lspconfig.nvim'},

		-- LSP Support
		{
			'neovim/nvim-lspconfig',
			dependencies = {
				'hrsh7th/cmp-nvim-lsp',
			},
		},

		-- Autocompletion
		{
			'hrsh7th/nvim-cmp',
			dependencies = {
				'L3MON4D3/LuaSnip',
				'saadparwaiz1/cmp_luasnip',
				'hrsh7th/cmp-nvim-lsp',
				'rafamadriz/friendly-snippets',
			}
		}
	}

})

