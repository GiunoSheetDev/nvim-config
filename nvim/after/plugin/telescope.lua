local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>q', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
