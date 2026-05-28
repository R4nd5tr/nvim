-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


-- Diagnostic Config & Keymaps
--  See `:help vim.diagnostic.Opts`
vim.diagnostic.config {
update_in_insert = false,
severity_sort = true,
float = { border = 'rounded', source = 'if_many' },
underline = { severity = { min = vim.diagnostic.severity.WARN } },

-- Can switch between these as you prefer
virtual_text = true, -- Text shows up at the end of the line
virtual_lines = false, -- Text shows up underneath the line, with virtual lines

-- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
jump = {
    on_jump = function(_, bufnr)
    vim.diagnostic.open_float {
        bufnr = bufnr,
        scope = 'cursor',
        focus = false,
    }
    end,
},
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })


-- Join lines without moving cursor position
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Window scrolling with cursor centering
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search match (centered)" })

-- Move selected lines while maintaining visual selection and indentation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })


-- Clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank entire line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without affecting clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })

vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Open file explorer" })

-- Disable Q
vim.keymap.set("n", "Q", "<nop>", { desc = "Disabled (was Ex mode)" })

-- terminal
-- vim.keymap.set("n", "<leader>t", "<C-w>s<cmd>term<CR>", { desc = "Toggle terminal" })