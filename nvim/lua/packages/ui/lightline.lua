vim.g.lightline_icon_git_branch = ""
vim.g.lightline_icon_git_added = ""
vim.g.lightline_icon_git_modified = ""
vim.g.lightline_icon_git_removed = ""

vim.g.lightline = {
  colorscheme = "one",
  active = {
    left = {
      { "mode", "paste" },
      { "readonly", "relativepath", "modified" },
    },
    right = {
      { "lineinfo" },
      { "percent" },
      { "gitbranch", "fileformat", "fileencoding", "filetype" },
    },
  },
  inactive = {
    left = {
      { "readonly", "relativepath", "modified" },
    },
    right = {
      { "gitbranch", "fileformat", "fileencoding", "filetype" },
    },
  },
  component = {
    filetype = "%{WebDevIconsGetFileTypeSymbol()} %{&ft !=# '' ? &ft : 'no ft'}",
  },
  component_function = {
    gitbranch = "LightlineGitBranch",
  },
  tab = {
    active = { "num", "icon", "filename", "modified", "readonly" },
    inactive = { "num", "icon", "filename", "modified", "readonly" },
  },
  tab_component_function = {
    num = "lightline#tab#tabnum",
    icon = "LightlineTabIcon",
    filename = "LightlineFileName",
    modified = "lightline#tab#modified",
    readonly = "lightline#tab#readonly",
  },
}

vim.api.nvim_exec(
  [[
  function! LightlineTabIcon(n) abort
    let buflist  = tabpagebuflist(a:n)
    let winnr    = tabpagewinnr(a:n)
    let filename = expand('#' . buflist[winnr - 1] . ':f')
    return WebDevIconsGetFileTypeSymbol(filename)
  endfunction

  function! LightlineFileName(n) abort
    let buflist = tabpagebuflist(a:n)
    let winnr   = tabpagewinnr(a:n)
    let _       = pathshorten(expand('#' . buflist[winnr - 1] . ':f'))
    return _ !=# '' ? _ : '[No Name]'
  endfunction

  function! LightlineGitBranch() abort
    return printf("%s %s", g:lightline_icon_git_branch, gitbranch#name())
  endfunction
]],
  false
)
