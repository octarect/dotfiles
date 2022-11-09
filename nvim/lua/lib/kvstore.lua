KVStore = {}

KVStore.prototype = {}
KVStore.prototype.get_key_file_path = function(self, key) return self.cache_path .. "/" .. key end

KVStore.prototype.write = function(self, key, value)
  local key_file_path = self:get_key_file_path(key)
  print(key_file_path)
  local f = io.open(key_file_path, "w")
  if not f then
    error(string.format("KVStore: cannot open key_file_path: %s", key_file_path))
  end
  f:write(value)
  f:close()
end

KVStore.prototype.read = function(self, key)
  local key_file_path = self:get_key_file_path(key)
  local f = io.open(key_file_path, "r")
  if not f then
    return nil
  end
  local value = f:read "a"
  f:close()
  return value
end

KVStore.new = function(cache_path, namespace)
  local obj = KVStore.prototype
  obj.cache_path = cache_path .. "/" .. namespace
  if not vim.fn.isdirectory(obj.cache_path) ~= 1 then
    os.execute("mkdir -p " .. obj.cache_path)
  end
  return obj
end

return KVStore
