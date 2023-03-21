local lspconfig = require "lspconfig"

-- Leading keys to use LSP function
local leader = "<LocalLeader>"

-- Custom border of hover window
_G.__MyLspFloatingOpts = {
  focusable = false,
  border = {
    { "+", "FloatBorder" },
    { "-", "FloatBorder" },
    { "+", "FloatBorder" },
    { "|", "FloatBorder" },
    { "+", "FloatBorder" },
    { "-", "FloatBorder" },
    { "+", "FloatBorder" },
    { "|", "FloatBorder" },
  },
}

local on_attach = function(client, bufnr)
  local function lspmap(m) return leader .. m end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local opts = { noremap = true, silent = true }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, _G.__MyLspFloatingOpts)
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Don't show message as virtual text
    virtual_text = false,
  })

  -- Navigate diagnostics
  buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({ float = _G.__MyLspFloatingOpts })<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({ float = _G.__MyLspFloatingOpts })<CR>", opts)

  buf_set_keymap("n", lspmap "h", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", lspmap "d", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", lspmap "D", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", lspmap "i", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", lspmap "t", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", lspmap "s", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", lspmap "a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", lspmap "o", "<cmd>lua vim.lsp.buf.references()<CR>", opts)

  -- Highlight a symbol and its references when holding the cursor
  if client.server_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup MyAutoCmdLspDocumentHighlight
        autocmd! * <buffer>
        autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end

  -- Show diagnostics which current line includes
  vim.api.nvim_exec(
    [[
    augroup MyAutoCmdLspDiagnostics
      autocmd!
      autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(0, _G.__MyLspFloatingOpts)
    augroup END
  ]],
    false
  )

  -- Add `:Format` command
  if client.server_capabilities.document_formatting then
    buf_set_keymap("n", lspmap "f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
  elseif client.server_capabilities.document_range_formatting then
    buf_set_keymap("n", lspmap "f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
  end

  -- Configure nvim-navic
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
end

local lsp_settings = {
  bashls = {},
  denols = {
    root_dir = lspconfig.util.root_pattern "deno.json",
    init_options = { lint = true },
  },
  dockerls = {},
  gopls = {},
  html = {},
  jsonls = {},
  solargraph = {},
  terraformls = {},
  tflint = {},
  tsserver = {
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
  },
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

local required_server_names = {}
for server_name, _ in pairs(lsp_settings) do
  required_server_names[#required_server_names + 1] = server_name
end

local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

require("mason").setup {}

require("mason-lspconfig").setup {
  ensure_installed = required_server_names,
}

require("mason-lspconfig").setup_handlers {
  function(server_name)
    local opts = {
      on_attach = on_attach,
      capabilities = capabilities,
    }
    -- Override settings
    if lsp_settings[server_name] ~= nil then
      for k, v in pairs(lsp_settings[server_name]) do
        opts[k] = v
      end
    end
    lspconfig[server_name].setup(opts)
    vim.cmd [[ do User LspAttachBuffers ]]
  end,
}
