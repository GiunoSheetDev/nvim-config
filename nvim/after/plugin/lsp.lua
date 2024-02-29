-- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/autocomplete.md#use-enter-to-confirm-completion

-- NOTE: if there are problems with parse_snippet deprecation
-- /usr/share/nvim/runtime/lua/vim/lsp/util.lua
-- a note is saved on commented warning
-- DEFAULT_util.lua is file before modifications

local lsp = require("lsp-zero")

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}


cmp.setup({
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lua" }

    },
    formatting = lsp.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- CR -> enter
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping.confirm({select = true}),
        --['<S-Tab>'] = nil,
    }),

    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },


})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.set_sign_icons({
    error = '✘',
    warn = '',
    hint = '󰍉',
    info = '»'
})



require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'rust_analyzer'},
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end,

  }
})

vim.diagnostic.config({
    virtual_text = true
})
