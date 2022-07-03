local cmp = require'cmp'
local types = require'cmp.types'
local lspkind = require'lspkind'
local tabnine = require'cmp_tabnine.config'

tabnine:setup {
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  priority = 5000,
}

local source_menus = {
  nvim_lsp    = '[LSP]',
  luasnip     = '[Snippet]',
  cmp_tabnine = '[TabNine]',
  buffer      = '[Buffer]',
  path        = '[Path]',
  emoji       = '[Emoji]',
  treesitter  = '[TS]',
}

cmp.setup {
  completion = {
    autocomplete = {
      types.cmp.TriggerEvent.InsertEnter,
      types.cmp.TriggerEvent.TextChanged
    },
  },
  sources = cmp.config.sources {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'treesitter' },
    { name = 'emoji' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'cmp_tabnine' },
  },
  snippet = {
    expand = function(args)
      require'luasnip'.lsp_expand(args.body)
    end
  },
  window = {
    documentation = {
      border = { '+', '-', '+', '|', '+', '-', '+', '|' },
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = function()
      if cmp.visible() then
        cmp.mapping.select_next_item()()
      else
        cmp.mapping.complete()()
      end
    end,
    ['<C-p>'] = function()
      if cmp.visible() then
        cmp.mapping.select_prev_item()()
      else
        cmp.mapping.complete()()
      end
    end,
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = lspkind.symbolic(vim_item.kind)
      local menu = source_menus[entry.source.name]
      if entry.source.name == 'cmp_tabnine' then
        _G.unk = entry.completion_item
        if entry.completion_item.data ~= nil and entry.completion_item.data.detail ~= nil then
          menu = entry.completion_item.data.detail .. ' ' .. menu
        end

        vim_item.kind = ''
        if entry.completion_item.kind ~= nil then
          vim_item.kind = vim_item.kind .. entry.completion_item.kind
        end
      end
      vim_item.menu = menu
      return vim_item
    end,
  },
}

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
  }, {
    { name = 'cmdline' },
  })
})
