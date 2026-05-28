vim.pack.add { gh 'akinsho/toggleterm.nvim' }
require('toggleterm').setup {
  size = 10,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  autochdir = false, -- when neovim changes it current directory the terminal will change it's own when next it's opened
  start_in_insert = true,
  persist_size = true,
  persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
  direction = 'horizontal',
  close_on_exit = true, -- close the terminal window when the process exits
  clear_env = false, -- use only environmental variables from `env`, passed to jobstart()
  auto_scroll = true, -- automatically scroll to the bottom on terminal output
}