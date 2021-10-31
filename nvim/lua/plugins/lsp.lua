-- Leading keys to use LSP function
local leader = '<LocalLeader>'

-- Custom border of hover window
_G.__MyLspFloatingOpts = {
  focusable = false,
  border = {
    {'+', 'FloatBorder'},
    {'-', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'|', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'-', 'FloatBorder'},
    {'+', 'FloatBorder'},
    {'|', 'FloatBorder'},
  },
}

local on_attach = function(client, bufnr)
  local function lspmap(m) return leader .. m end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, _G.__MyLspFloatingOpts)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      -- Don't show message as virtual text
      virtual_text = false,
    }
  )

  -- Navigate diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev({ popup_opts = _G.__MyLspFloatingOpts })<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next({ popup_opts = _G.__MyLspFloatingOpts })<CR>', opts)

  buf_set_keymap('n', lspmap('h'), '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', lspmap('d'), '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', lspmap('D'), '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', lspmap('i'), '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', lspmap('t'), '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', lspmap('s'), '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', lspmap('a'), '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', lspmap('o'), '<cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Highlight a symbol and its references when holding the cursor
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec([[
      augroup MyAutoCmdLspDocumentHighlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]], false)
  end

  -- Show diagnostics which current line includes
  vim.api.nvim_exec([[
    augroup MyAutoCmdLspDiagnostics
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.lsp.diagnostic.show_line_diagnostics(_G.__MyLspFloatingOpts)
    augroup END
  ]], false)

  -- Add `:Format` command
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', lspmap('f'), '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', lspmap('f'), '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local lsp_settings = {
  bashls = {},
  dockerls = {},
  gopls = {},
  html = {},
  jsonls = {},
  solargraph = {},
  sumneko_lua = {},
  tsserver = {},
  vimls = {},
  yamlls = {
    settings = {
      yaml = {
        schemas = {
          kubernetes = "/*.yaml",
          ["https://json.schemastore.org/ansible-playbook.json"] = { "/playbook.yml", "/ansible/*.yml" },
          ["https://json.schemastore.org/ansible-role-2.9.json"] = { "/roles/tasks/*.yml" },
        },
      },
    },
  },
}

local capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'nvim-lsp-installer'.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }
  if lsp_settings[server.name] ~= nil and lsp_settings[server.name].settings ~= nil then
    opts.settings = lsp_settings[server.name].settings
  end
  server:setup(opts)
  vim.cmd [[ do User LspAttachBuffers ]]
end)

local lsp_installer_servers = require'nvim-lsp-installer.servers'
for server_name, _ in pairs(lsp_settings) do
  local ok, server = lsp_installer_servers.get_server(server_name)
  if ok then
    if not server:is_installed() then
      server:install()
    end
  end
end
