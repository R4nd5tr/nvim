-- PACKETS
-- ===========================================
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    return
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
{
    "kylechui/nvim-surround",
    version = "^4.0.0", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    -- Optional: See `:h nvim-surround.configuration` and `:h nvim-surround.setup` for details
    config = function()
        require("nvim-surround").setup({
            -- Put your configuration here
        })
    end
},{
  "justinmk/vim-sneak",
  init = function()
    vim.g["sneak#label"] = 1        -- 开启标签跳转模式（类似 easymotion）
    vim.g["sneak#s_next"] = 1       -- 按 s/S 继续跳到下一个/上一个匹配
    vim.g["sneak#use_ic_scs"] = 1   -- 智能大小写
  end,
}
})


-- OPTIONS
-- ===========================================
-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

vim.g.have_nerd_font = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 1000

vim.opt.smartindent = true

-- KEYMAPS
-- ===========================================
-- Clipboard
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without overwriting register" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank entire line to system clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d", { desc = "Delete without affecting clipboard" })
-- vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

-- vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode with Ctrl+C" })

-- skip folds (down, up)
vim.cmd('nmap j gj')
vim.cmd('nmap k gk')


-- Disable Q
vim.keymap.set("n", "Q", "<nop>", { desc = "Disabled (was Ex mode)" })

-- These are defined in VSCode keybindings.json
-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
-- keybindings.json:
-- {
--   "key": "ctrl+d",
--   "command": "runCommands",
--   "when": "editorTextFocus && neovim.init && neovim.mode == 'normal'",
--   "args": {
--     "commands": [
--       { "command": "editorScroll", "args": { "to": "down", "by": "halfPage" } },
--       { "command": "cursorMove", "args": { "to": "viewPortCenter" } }
--     ]
--   }
-- },
-- {
--   "key": "ctrl+u",
--   "command": "runCommands",
--   "when": "editorTextFocus && neovim.init && neovim.mode == 'normal'",
--   "args": {
--     "commands": [
--       { "command": "editorScroll", "args": { "to": "up", "by": "halfPage" } },
--       { "command": "cursorMove", "args": { "to": "viewPortCenter" } }
--     ]
--   }
-- }
vim.keymap.set("n", "n", function()
  vim.cmd.normal({"n", bang = true })
  require("vscode").action("revealLine", { args = { lineNumber = vim.fn.line(".") - 1, at = "center" } })
end, { desc = "Next search match (centered)" })
vim.keymap.set("n", "N", function()
  vim.cmd.normal({"N", bang = true })
  require("vscode").action("revealLine", { args = { lineNumber = vim.fn.line(".") - 1, at = "center" } })
end, { desc = "Previous search match (centered)" })

-- Join lines without moving cursor position
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines without moving cursor" })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

if vim.g.vscode then
  local opts = { noremap = true, silent = true }
  local mappings = {
    { 'n', '<leader>e', 'workbench.files.action.focusFilesExplorer' },

  }
  for _, mapping in ipairs(mappings) do
    local mode, key, command = mapping[1], mapping[2], mapping[3]

    vim.keymap.set(mode, key, function() require("vscode").action(command) end, opts)
  end
end



-- AUTO COMMANDS
-- ===========================================
-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
})
