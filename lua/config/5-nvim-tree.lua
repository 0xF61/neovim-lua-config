require("nvim-tree").setup({
	sort_by = "case_sensitive",
	filters = {
		dotfiles = true,
	},
	on_attach = function(bufnr)
		local api = require('nvim-tree.api')

		local function opts(desc)
			return {
				desc = 'nvim-tree: ' .. desc,
				buffer = bufnr,
				noremap = true,
				silent = true,
				nowait = true,
			}
		end

		api.config.mappings.default_on_attach(bufnr)

		vim.keymap.set('n', 's', api.node.open.vertical, opts('Open: Vertical Split'))
		vim.keymap.set('n', 'i', api.node.open.horizontal, opts('Open: Horizontal Split'))
		vim.keymap.set('n', 'u', api.tree.change_root_to_parent, opts('Up'))
	end
})
