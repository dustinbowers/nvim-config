local nnoremap = require("user.keymap_utils").nnoremap
local vnoremap = require("user.keymap_utils").vnoremap
local inoremap = require("user.keymap_utils").inoremap
local tnoremap = require("user.keymap_utils").tnoremap
local xnoremap = require("user.keymap_utils").xnoremap
local harpoon_ui = require("harpoon.ui")
local harpoon_mark = require("harpoon.mark")
local illuminate = require("illuminate")
local utils = require("user.utils")

local M = {}

local TERM = os.getenv("TERM")

-- Normal --
-- Disable Space bar since it'll be used as the leader key
nnoremap("<space>", "<nop>")

-- Do things without affecting the registers
nnoremap("x", '"_x')
nnoremap("<Leader>p", '"0p')
nnoremap("<Leader>P", '"0P')
nnoremap("<Leader>p", '"0p')
nnoremap("<Leader>c", '"_c')
nnoremap("<Leader>C", '"_C')
vnoremap("<Leader>c", '"_c')
vnoremap("<Leader>C", '"_C')
nnoremap("<Leader>d", '"_d')
nnoremap("<Leader>D", '"_D')
vnoremap("<Leader>d", '"_d')
vnoremap("<Leader>D", '"_D')

-- Window +  better kitty navigation
nnoremap("<C-j>", function()
	if vim.fn.exists(":KittyNavigateDown") ~= 0 and TERM == "xterm-kitty" then
		vim.cmd.KittyNavigateDown()
	elseif vim.fn.exists(":NvimTmuxNavigateDown") ~= 0 then
		vim.cmd.NvimTmuxNavigateDown()
	else
		vim.cmd.wincmd("j")
	end
end, { desc = "KittyNavigateDown, or NvimTmuxNavigateDown or wincmd j" })

nnoremap("<C-k>", function()
	if vim.fn.exists(":KittyNavigateUp") ~= 0 and TERM == "xterm-kitty" then
		vim.cmd.KittyNavigateUp()
	elseif vim.fn.exists(":NvimTmuxNavigateUp") ~= 0 then
		vim.cmd.NvimTmuxNavigateUp()
	else
		vim.cmd.wincmd("k")
	end
end, { desc = "KittyNavigateUp, or NvimTmuxNavigateUp or wincmd k" })

nnoremap("<C-l>", function()
	if vim.fn.exists(":KittyNavigateRight") ~= 0 and TERM == "xterm-kitty" then
		vim.cmd.KittyNavigateRight()
	elseif vim.fn.exists(":NvimTmuxNavigateRight") ~= 0 then
		vim.cmd.NvimTmuxNavigateRight()
	else
		vim.cmd.wincmd("l")
	end
end, { desc = "KittyNavigateRight, or NvimTmuxNavigateRight or wincmd l" })

nnoremap("<C-h>", function()
	if vim.fn.exists(":KittyNavigateLeft") ~= 0 and TERM == "xterm-kitty" then
		vim.cmd.KittyNavigateLeft()
	elseif vim.fn.exists(":NvimTmuxNavigateLeft") ~= 0 then
		vim.cmd.NvimTmuxNavigateLeft()
	else
		vim.cmd.wincmd("h")
	end
end, { desc = "KittyNavigateLeft, or NvimTmuxNavigateLeft or wincmd h" })

-- quick tab selection
nnoremap("<A-h>", "gT", { desc = "Previous tab" })
nnoremap("<A-l>", "gt", { desc = "Next tab" })
nnoremap("<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

--
-- Goto-Preview config
nnoremap("<leader>pd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>")
nnoremap("<leader>pt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>")
nnoremap("<leader>pi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>")
nnoremap("<leader>pD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>")
nnoremap("<leader>pc", "<cmd>lua require('goto-preview').close_all_win()<CR>")
nnoremap("<leader>pr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>")

-- Fzf-lua
nnoremap("<leader>fp", ":FzfLua grep_project<CR>", { desc = "[F]zf grep [P]roject" })
nnoremap("<leader>fb", ":FzfLua grep_curbuf<CR>", { desc = "[F]zf grep current [B]uffer" })
nnoremap("<leader>fw", ":FzfLua grep_cword<CR>", { desc = "[F]zf grep [W]ord under cursor" })
nnoremap("<leader>fg", ":FzfLua grep<CR>", { desc = "[F]zf [G]rep" })

-- Swap between last two buffers
nnoremap("<leader>'", "<C-^>", { desc = "Switch to last buffer" })

-- Save with leader key
nnoremap("<leader>w", "<cmd>w<CR>", { silent = false, desc = "Save with leader key" })

-- Quit with leader key
nnoremap("<leader>q", "<cmd>q<CR>", { silent = false, desc = "Quit with leader key" })

-- Save and Quit with leader key
nnoremap("<leader>z", "<cmd>wq<CR>", { silent = false, desc = "Save and Quit with leader key" })

-- Map Oil to <leader>e
nnoremap("<leader>e", function()
	require("oil").toggle_float()
end, { desc = "Toggle oil" })

-- Center buffer while navigating
nnoremap("<C-u>", "<C-u>zz")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("{", "{zz")
nnoremap("}", "}zz")
nnoremap("N", "Nzz")
nnoremap("n", "nzz")
nnoremap("G", "Gzz")
nnoremap("gg", "ggzz")
nnoremap("<C-i>", "<C-i>zz")
nnoremap("<C-o>", "<C-o>zz")
nnoremap("%", "%zz")
nnoremap("*", "*zz")
nnoremap("#", "#zz")

-- Press 'S' for quick find/replace for the word under the cursor
nnoremap("S", function()
	local cmd = ":%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>"
	local keys = vim.api.nvim_replace_termcodes(cmd, true, false, true)
	vim.api.nvim_feedkeys(keys, "n", false)
end, { desc = "Quick find/replace for the word under the cursor" })

-- Open Spectre for global find/replace
nnoremap("<leader>S", function()
	require("spectre").toggle()
end, { desc = "Open Spectre for global find/replace" })

-- Open Spectre for global find/replace for the word under the cursor in normal mode
nnoremap("<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Open Spectre for global find/replace of word under the cursor in normal mode" })

-- Open Spectre for global find/replace for the word under the cursor in visual mode
vnoremap("<leader>sw", function()
	require("spectre").open_visual({ select_word = true })
end, { desc = "Open Spectre for global find/replace of word under the cursor in visual mode" })

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
nnoremap("L", "$")
nnoremap("H", "^")

-- Press 'U' for Redo
nnoremap("U", "<C-r>", { desc = "Redo previous Undo" })

-- Turn off highlighted results
nnoremap("<leader>no", "<cmd>noh<CR>", { desc = "Turn off highlighted results" })

-- Diagnostics

-- Goto next diagnostic of any severity
nnoremap("]d", function()
	vim.diagnostic.goto_next({})
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next diagnostic of any severity" })

-- Goto previous diagnostic of any severity
nnoremap("[d", function()
	vim.diagnostic.goto_prev({})
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous diagnostic of any severity" })

-- Goto next error diagnostic
nnoremap("]e", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next error diagnostic" })

-- Goto previous error diagnostic
nnoremap("[e", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous error diagnostic" })

-- Goto next warning diagnostic
nnoremap("]w", function()
	vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto next warning diagnostic" })

-- Goto previous warning diagnostic
nnoremap("[w", function()
	vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.WARN })
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Goto previous warning diagnostic" })

-- nnoremap("<leader>d", function()
-- 	vim.diagnostic.open_float({
-- 		border = "rounded",
-- 	})
-- end, { desc = "Open diagnostic float" })
--
-- -- Place all dignostics into a qflist
-- nnoremap("<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })
--
-- -- Navigate to next qflist item
-- nnoremap("<leader>cn", ":cnext<CR>zz", { desc = "Goto next QuickFixList item" })
--
-- -- Navigate to previos qflist item
-- nnoremap("<leader>cp", ":cprevious<CR>zz", { desc = "Goto previous QuickFixList item" })
--
-- -- Open the qflist
-- nnoremap("<leader>co", ":copen<CR>zz", { desc = "Open QuickFixList" })
--
-- -- Close the qflist
-- nnoremap("<leader>cc", ":cclose<CR>zz", { desc = "Close QuickFixList" })

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
nnoremap("<leader>m", ":MaximizerToggle<CR>", { desc = "MaximizerToggle" })

-- Resize split windows to be equal size
nnoremap("<leader>=", "<C-w>=", { desc = "Resize split windows to be equal size" })

-- Press leader f to format
nnoremap("<leader>f", ":Format<CR>", { desc = "Format code" })

-- Press leader rw to rotate open windows
nnoremap("<leader>rw", ":RotateWindows<CR>", { desc = "[R]otate [W]indows" })

-- Press gx to open the link under the cursor
nnoremap("gx", ":sil !open <cWORD><CR>", { silent = true, desc = "Open link under the cusor" })

-- Debugger --
nnoremap("<leader>db", ":DapToggleBreakpoint<CR>")
nnoremap("<leader>dpr", function()
	require("dap-python").test_method()
end, { desc = "[D]ebug [P]ython [R]un" })

-- Harpoon keybinds --
-- Open harpoon ui
nnoremap("<leader>ho", function()
	harpoon_ui.toggle_quick_menu()
end, { desc = "Toggle Harpoon" })

-- Add current file to harpoon
nnoremap("<leader>ha", function()
	harpoon_mark.add_file()
end, { desc = "Add file to Harpoon" })

-- Remove current file from harpoon
nnoremap("<leader>hr", function()
	harpoon_mark.rm_file()
end, { desc = "Remove current file from Harpoon" })

-- Remove all files from harpoon
nnoremap("<leader>hc", function()
	harpoon_mark.clear_all()
end, { desc = "Clear all files from Harpoon" })

-- Quickly jump to harpooned files
nnoremap("<leader>1", function()
	harpoon_ui.nav_file(1)
end, { desc = "Jump to Harpooned file #1" })

nnoremap("<leader>2", function()
	harpoon_ui.nav_file(2)
end, { desc = "Jump to Harpooned file #2" })

nnoremap("<leader>3", function()
	harpoon_ui.nav_file(3)
end, { desc = "Jump to Harpooned file #3" })

nnoremap("<leader>4", function()
	harpoon_ui.nav_file(4)
end, { desc = "Jump to Harpooned file #4" })

nnoremap("<leader>5", function()
	harpoon_ui.nav_file(5)
end, { desc = "Jump to Harpooned file #5" })

-- Git keymaps --
nnoremap("<leader>gb", ":Gitsigns toggle_current_line_blame<CR>")
nnoremap("<leader>gf", function()
	local cmd = {
		"sort",
		"-u",
		"<(git diff --name-only --cached)",
		"<(git diff --name-only)",
		"<(git diff --name-only --diff-filter=U)",
	}

	if not utils.is_git_directory() then
		vim.notify(
			"Current project is not a git directory",
			vim.log.levels.WARN,
			{ title = "Telescope Git Files", git_command = cmd }
		)
	else
		require("telescope.builtin").git_files()
	end
end, { desc = "Search [G]it [F]iles" })

-- Telescope keybinds --
nnoremap("<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
nnoremap("<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch Open [B]uffers" })
nnoremap("<leader>sf", function()
	require("telescope.builtin").find_files({ hidden = true })
end, { desc = "[S]earch [F]iles" })
nnoremap("<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
nnoremap("<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
nnoremap("<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
nnoremap("<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
nnoremap("<leader>sd", require("telescope.builtin").git_files, { desc = "[S]earch [D]iagnostics" })

nnoremap("<leader>sc", function()
	require("telescope.builtin").commands(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [C]ommands" })

nnoremap("<leader>/", function()
	require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[/] Fuzzily search in current buffer]" })

nnoremap("<leader>ss", function()
	require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
		previewer = false,
	}))
end, { desc = "[S]earch [S]pelling suggestions" })

-- LSP Keybinds (exports a function to be used in ../../after/plugin/lsp.lua b/c we need a reference to the current buffer) --
M.map_lsp_keybinds = function(buffer_number)
	nnoremap("<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame", buffer = buffer_number })
	nnoremap("<leader>ca", vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction", buffer = buffer_number })

	nnoremap("gd", vim.lsp.buf.definition, { desc = "LSP: [G]oto [D]efinition", buffer = buffer_number })

	-- Telescope LSP keybinds --
	nnoremap(
		"gr",
		require("telescope.builtin").lsp_references,
		{ desc = "LSP: [G]oto [R]eferences", buffer = buffer_number }
	)

	nnoremap(
		"gi",
		require("telescope.builtin").lsp_implementations,
		{ desc = "LSP: [G]oto [I]mplementation", buffer = buffer_number }
	)

	nnoremap(
		"<leader>bs",
		require("telescope.builtin").lsp_document_symbols,
		{ desc = "LSP: [B]uffer [S]ymbols", buffer = buffer_number }
	)

	nnoremap(
		"<leader>ps",
		require("telescope.builtin").lsp_workspace_symbols,
		{ desc = "LSP: [P]roject [S]ymbols", buffer = buffer_number }
	)

	-- See `:help K` for why this keymap
	nnoremap("K", vim.lsp.buf.hover, { desc = "LSP: Hover Documentation", buffer = buffer_number })
	nnoremap("<leader>k", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })
	inoremap("<C-k>", vim.lsp.buf.signature_help, { desc = "LSP: Signature Documentation", buffer = buffer_number })

	-- Lesser used LSP functionality
	nnoremap("gD", vim.lsp.buf.declaration, { desc = "LSP: [G]oto [D]eclaration", buffer = buffer_number })
	nnoremap("td", vim.lsp.buf.type_definition, { desc = "LSP: [T]ype [D]efinition", buffer = buffer_number })
end

-- Symbol Outline keybind
nnoremap("<leader>so", ":SymbolsOutline<CR>")

-- Tree
--nnoremap("<A-k>", "<cmd> NvimTreeToggle<CR>")
nnoremap("<A-o>", ":NvimTreeToggle<CR>:wincmd =<CR>")

-- Vim Illuminate keybinds
nnoremap("<leader>]", function()
	illuminate.goto_next_reference()
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Illuminate: Goto next reference" })

nnoremap("<leader>[", function()
	illuminate.goto_prev_reference()
	vim.api.nvim_feedkeys("zz", "n", false)
end, { desc = "Illuminate: Goto previous reference" })

-- Open Copilot panel
-- nnoremap("<leader>oc", function()
-- 	require("copilot.panel").open({})
-- end, { desc = "[O]pen [C]opilot panel" })

-- nvim-ufo keybinds
-- Disabling plugins/ufo.lua for now, it bugs treesitter
-- nnoremap("zR", require("ufo").openAllFolds)
-- nnoremap("zM", require("ufo").closeAllFolds)

-- Insert --
-- Map jj to <esc>
inoremap("jj", "<esc>")

-- Visual --
-- Disable Space bar since it'll be used as the leader key
vnoremap("<space>", "<nop>")

-- Press 'H', 'L' to jump to start/end of a line (first/last char)
vnoremap("L", "$<left>", { desc = "Visual - Jump to end of line" })
vnoremap("H", "^", { desc = "Visual - Jump to beginning of line" })

-- Paste without losing the contents of the register
-- xnoremap("<leader>p", '"_dP', { desc = "Paste without losing contents of the register" })

-- Move selected text up/down in visual mode
vnoremap("<A-j>", ":m '>+1<CR>gv=gv", { desc = "Visual - move selected line Up" })
vnoremap("<A-k>", ":m '<-2<CR>gv=gv", { desc = "Visual - move selected line Down" })

-- Reselect the last visual selection
xnoremap("<<", function()
	vim.cmd("normal! <<")
	vim.cmd("normal! gv")
end, { desc = "Visual-Block, reselect the last visual selection ??" })

xnoremap(">>", function()
	vim.cmd("normal! >>")
	vim.cmd("normal! gv")
end, { desc = "Visual-Block, reselect the last visual selection ??" })

-- Terminal --
-- Enter normal mode while in a terminal
tnoremap("<esc>", [[<C-\><C-n>]], { desc = "Enter normal mode from a terminal" })
tnoremap("jj", [[<C-\><C-n>]], { desc = "Enter normal mode from a terminal" })

-- Window navigation from terminal
tnoremap("<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Window navigation from a terminal" })
tnoremap("<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Window navigation from a terminal" })
tnoremap("<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Window navigation from a terminal" })
tnoremap("<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Window navigation from a terminal" })

-- Reenable default <space> functionality to prevent input delay
tnoremap("<space>", "<space>")

return M
