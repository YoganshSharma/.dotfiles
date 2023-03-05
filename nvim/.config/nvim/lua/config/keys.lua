local util = require("util")
local wk = require("which-key")

vim.o.timeoutlen = 300

local presets = require("which-key.plugins.presets")
presets.objects["a("] = nil
wk.setup({
	show_help = false,
	triggers = "auto",
	plugins = { spelling = true },
	key_labels = { ["<leader>"] = "SPC" },
})

util.nnoremap("<leader>tt", ":Ex<CR>")
util.nnoremap("<leader>u", ":UndotreeShow<CR>")

util.vnoremap("J", ":m '>+1<CR>gv=gv")
util.vnoremap("K", ":m '<-2<CR>gv=gv")

util.nnoremap("Y", "yg$")
util.nnoremap("n", "nzzzv")
util.nnoremap("N", "Nzzzv")
util.nnoremap("J", "mzJ`z")
util.nnoremap("<C-d>", "<C-d>zz")
util.nnoremap("<C-u>", "<C-u>zz")

util.nnoremap("S", ":%s/<C-r><C-w>/<C-r>C-w>/gI<Left><Left><Left>")

-- greatest remap ever
util.xnoremap("<leader>P", "\"+P")
util.nnoremap("<leader>P", "\"+P")
util.xnoremap("<leader>p", "\"+p")
util.nnoremap("<leader>p", "\"+p")

-- next greatest remap ever : asbjornHaland
util.nnoremap("<leader>y", "\"+y")
util.nmap("<leader>Y", "\"+Y")
util.nmap("<leader>Y", "\"+Y")
util.vnoremap("<leader>y", "\"+y")

util.nnoremap("<leader>d", "\"_d")
util.vnoremap("<leader>d", "\"_d")

util.vnoremap("<leader>d", "\"_d")

-- Better tabbing
util.vnoremap("<", "<gv")
util.vnoremap(">", ">gv")

-- Use alt + hjkl to resize windows
util.nnoremap("<M-j>", ":resize -2<CR>")
util.nnoremap("<M-k>", ":resize +2<CR>")
util.nnoremap("<M-h>", ":vertical resize -2<CR>")
util.nnoremap("<M-l>", ":vertical resize +2<CR>")


-- TAB in general mode will move to text buffer
util.nnoremap("<TAB>", ":bnext<CR>")
util.nnoremap("<C-c>", ":bw<CR>")

-- SHIFT-TAB will go back
util.nnoremap("<S-TAB>", ":bprevious<CR>")

util.nnoremap("S", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

util.nnoremap("<leader>cf", function()
	vim.lsp.buf.formatting()
end)

-- Move to window using the <ctrl> movement keys
util.nmap("<left>", "<C-w>h")
util.nmap("<down>", "<C-w>j")
util.nmap("<up>", "<C-w>k")
util.nmap("<right>", "<C-w>l")

-- Move Lines
util.nnoremap("<C-j>", ":m .+1<CR>==")
util.vnoremap("<C-j>", ":m '>+1<CR>gv=gv")
util.inoremap("<C-j>", "<Esc>:m .+1<CR>==gi")
util.nnoremap("<C-k>", ":m .-2<CR>==")
util.vnoremap("<C-k>", ":m '<-2<CR>gv=gv")
util.inoremap("<C-k>", "<Esc>:m .-2<CR>==gi")

-- Switch buffers with tab
util.nnoremap("<C-Left>", ":bprevious<cr>")
util.nnoremap("<C-Right>", ":bnext<cr>")

-- Easier pasting
util.nnoremap("[p", ":pu!<cr>")
util.nnoremap("]p", ":pu<cr>")

-- Clear search with <esc>
util.map("", "<esc>", ":noh<cr>")
util.nnoremap("gw", "*N")
util.xnoremap("gw", "*N")

-- save in insert mode
util.inoremap("<C-s>", "<esc>:w<cr>")
util.nnoremap("<C-s>", "<esc>:w<cr>")

-- makes * and # work on visual mode too.
vim.api.nvim_exec(
	[[
  function! g:VSetSearch(cmdtype)
    let temp = @s
    norm! gv"sy
    let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
    let @s = temp
  endfunction

  xnoremap * :<C-u>call g:VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
  xnoremap # :<C-u>call g:VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
]],
	false
)

local leader = {
	["w"] = {
		name = "+windows",
		["w"] = { "<C-W>p", "other-window" },
		["d"] = { "<C-W>c", "delete-window" },
		["-"] = { "<C-W>s", "split-window-below" },
		["|"] = { "<C-W>v", "split-window-right" },
		["2"] = { "<C-W>v", "layout-double-columns" },
		["h"] = { "<C-W>h", "window-left" },
		["j"] = { "<C-W>j", "window-below" },
		["l"] = { "<C-W>l", "window-right" },
		["k"] = { "<C-W>k", "window-up" },
		["H"] = { "<C-W>5<", "expand-window-left" },
		["J"] = { ":resize +5", "expand-window-below" },
		["L"] = { "<C-W>5>", "expand-window-right" },
		["K"] = { ":resize -5", "expand-window-up" },
		["="] = { "<C-W>=", "balance-window" },
		["s"] = { "<C-W>s", "split-window-below" },
		["v"] = { "<C-W>v", "split-window-right" },
	},
	c = { v = { "<cmd>Vista!!<CR>", "Vista" }, O = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" } },
	b = {
		name = "+buffer",
		["b"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
		["p"] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
		["["] = { "<cmd>:BufferLineCyclePrev<CR>", "Previous Buffer" },
		["n"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
		["]"] = { "<cmd>:BufferLineCycleNext<CR>", "Next Buffer" },
		["d"] = { "<cmd>:BDelete this<CR>", "Delete Buffer" },
		["D"] = { "<cmd>:bd<CR>", "Delete Buffer & Window" },
		["g"] = { "<cmd>:BufferLinePick<CR>", "Goto Buffer" },
	},
	g = {
		name = "+git",
		-- g = { "<cmd>Neogit kind=split<CR>", "NeoGit" },
		-- l = {
		--   function()
		--     require("util").float_terminal("lazygit")
		--   end,
		--   "LazyGit",
		-- },
		c = { "<Cmd>Telescope git_commits<CR>", "commits" },
		b = { "<Cmd>Telescope git_branches<CR>", "branches" },
		s = { "<Cmd>Telescope git_status<CR>", "status" },
		d = { "<cmd>DiffviewOpen<cr>", "DiffView" },
		h = { name = "+hunk" },
	},
	["h"] = {
		name = "+help",
		t = { "<cmd>:Telescope builtin<cr>", "Telescope" },
		c = { "<cmd>:Telescope commands<cr>", "Commands" },
		h = { "<cmd>:Telescope help_tags<cr>", "Help Pages" },
		m = { "<cmd>:Telescope man_pages<cr>", "Man Pages" },
		k = { "<cmd>:Telescope keymaps<cr>", "Key Maps" },
		s = { "<cmd>:Telescope highlights<cr>", "Search Highlight Groups" },
		l = { [[<cmd>TSHighlightCapturesUnderCursor<cr>]], "Highlight Groups at cursor" },
		f = { "<cmd>:Telescope filetypes<cr>", "File Types" },
		o = { "<cmd>:Telescope vim_options<cr>", "Options" },
		a = { "<cmd>:Telescope autocommands<cr>", "Auto Commands" },
		p = {
			name = "+packer",
			p = { "<cmd>PackerSync<cr>", "Sync" },
			s = { "<cmd>PackerStatus<cr>", "Status" },
			i = { "<cmd>PackerInstall<cr>", "Install" },
			c = { "<cmd>PackerCompile<cr>", "Compile" },
		},
	},
	u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
	s = {
		name = "+search",
		g = { "<cmd>Telescope live_grep<cr>", "Grep" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
		s = {
			function()
				require("telescope.builtin").lsp_document_symbols({
					symbols = { "Class", "Function", "Method", "Constructor", "Interface", "Module", "Struct", "Trait" },
				})
			end,
			"Goto Symbol",
		},
		h = { "<cmd>Telescope command_history<cr>", "Command History" },
		m = { "<cmd>Telescope marks<cr>", "Jump to Mark" },
		r = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace" },
	},
	f = {
		name = "+file",
		t = { "<cmd>NvimTreeToggle<cr>", "NvimTree" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		n = { "<cmd>enew<cr>", "New File" },
		-- z = "Zoxide",
		d = "Dot Files",
	},
	o = {
		name = "+open",
		p = { "<cmd>MarkdownPreview<cr>", "Markdown Preview" },
		g = { "<cmd>Glow<cr>", "Markdown Glow" },
		n = { "<cmd>lua require('github-notifications.menu').notifications()<cr>", "GitHub Notifications" },
	},
	t = {
		name = "toggle",
		f = {
			require("config.lsp.formatting").toggle,
			"Format on Save",
		},
		s = {
			function()
				util.toggle("spell")
			end,
			"Spelling",
		},
		w = {
			function()
				util.toggle("wrap")
			end,
			"Word Wrap",
		},
		n = {
			function()
				util.toggle("relativenumber", true)
				util.toggle("number")
			end,
			"Line Numbers",
		},
	},
	["<tab>"] = {
		name = "workspace",
		["<tab>"] = { "<cmd>tabnew<CR>", "New Tab" },

		n = { "<cmd>tabnext<CR>", "Next" },
		d = { "<cmd>tabclose<CR>", "Close" },
		p = { "<cmd>tabprevious<CR>", "Previous" },
		["]"] = { "<cmd>tabnext<CR>", "Next" },
		["["] = { "<cmd>tabprevious<CR>", "Previous" },
		f = { "<cmd>tabfirst<CR>", "First" },
		l = { "<cmd>tablast<CR>", "Last" },
	},
	["`"] = { "<cmd>:e #<cr>", "Switch to Other Buffer" },
	[" "] = "Find File",
	["."] = { ":Telescope file_browser<CR>", "Browse Files" },
	[","] = { "<cmd>Telescope buffers show_all_buffers=true<cr>", "Switch Buffer" },
	["/"] = { "<cmd>Telescope live_grep<cr>", "Search" },
	[":"] = { "<cmd>Telescope command_history<cr>", "Command History" },
	["C"] = {
		function()
			util.clipman()
		end,
		"Clipman",
	},
	q = {
		name = "+quit/session",
		q = { "<cmd>:qa<cr>", "Quit" },
		["!"] = { "<cmd>:qa!<cr>", "Quit without saving" },
		s = { [[<cmd>lua require("persistence").load()<cr>]], "Restore Session" },
		l = { [[<cmd>lua require("persistence").load({last=true})<cr>]], "Restore Last Session" },
		d = { [[<cmd>lua require("persistence").stop()<cr>]], "Stop Current Session" },
	},
	x = {
		name = "+errors",
		x = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Trouble" },
		t = { "<cmd>TodoTrouble<cr>", "Todo Trouble" },
		T = { "<cmd>TodoTelescope<cr>", "Todo Telescope" },
		l = { "<cmd>lopen<cr>", "Open Location List" },
		q = { "<cmd>copen<cr>", "Open Quickfix List" },
	},
	Z = { [[<cmd>lua require("zen-mode").reset()<cr>]], "Zen Mode" },
	z = { [[<cmd>ZenMode<cr>]], "Zen Mode" },
	T = { [[<Plug>PlenaryTestFile]], "Plenary Test" },
	D = {
		function()
			util.docs()
		end,
		"Create Docs from README.md",
	},
}

for i = 0, 10 do
	leader[tostring(i)] = "which_key_ignore"
end

wk.register(leader, { prefix = "<leader>" })
