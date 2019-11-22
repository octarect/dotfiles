let s:local_config_path = expand('$HOME/.local/share/nvim/local')

function! s:open_local(name) abort
    call mkdir(s:local_config_path, 'p')
    let l:path = rc#local#get_path(a:name)
    execute 'edit!' l:path
endfunction

function! rc#local#get_path(name)
    return s:local_config_path . '/' . a:name
endfunction

command! LocalDein :call <SID>open_local('dein_local.toml')
