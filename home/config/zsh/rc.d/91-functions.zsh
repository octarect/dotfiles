pcd() {
  local project_dir=$(ghq list --full-path | peco --query "${LBUFFER}" --layout=bottom-up)
  if [[ -n "${project_dir}" ]]; then
      cd "${project_dir}"
  fi
}
