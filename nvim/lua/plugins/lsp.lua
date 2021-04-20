local server_settings = {
  yaml = {
    yaml = {
      schemas = {
        kubernetes = "/*.yaml",
      },
    },
  },
}

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { 
      -- Don't show message as virtual text
      virtual_text = false,
    }
  )

  -- Navigate diagnostics
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

  -- Call hover() when holding cursor
  -- vim.cmd('autocmd CursorHold * lua vim.lsp.buf.hover()')
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
      autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
    augroup END
  ]], false)

  -- Add `:Format` command
  if client.resolved_capabilities.document_formatting then
    buf_set_keymap('n', '<Leader>F', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  elseif client.resolved_capabilities.document_range_formatting then
    buf_set_keymap('n', '<Leader>F', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
end

local function setup_servers()
  require'lspinstall'.setup()
  local servers = require'lspinstall'.installed_servers()
  for _, server in pairs(servers) do
    local options = { on_attach = on_attach }
    if server_settings[server] ~= nil then
      options.settings = server_settings[server]
    end
    require'lspconfig'[server].setup(options)
  end
end

setup_servers()

-- Automatically reload after `LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
  setup_servers()
  vim.cmd("bufdo e")
end
