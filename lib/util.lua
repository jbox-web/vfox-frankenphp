function get_platform()
  -- RUNTIME object is provided by mise/vfox
  -- RUNTIME.osType: "Windows", "Linux", "Darwin"
  -- RUNTIME.archType: "amd64", "386", "arm64", etc.

  local os_name = RUNTIME.osType:lower()
  local arch = RUNTIME.archType

  -- Map to your tool's platform naming convention
  -- Adjust these mappings based on how your tool names its releases
  local platform_map = {
    ["darwin"] = {
      ["amd64"] = "mac-x86_64",
      ["arm64"] = "mac-arm64",
    },
    ["linux"] = {
      ["amd64"] = "linux-x86_64",
      ["arm64"] = "linux-aarch64",
      ["386"]   = "linux-386",
    },
    ["windows"] = {
      ["amd64"] = "windows-x86_64",
      ["386"]   = "windows-386",
    }
  }

  local os_map = platform_map[os_name]
  if os_map then
    return os_map[arch] or "linux_amd64"  -- fallback
  end

  -- Default fallback
  return "linux_amd64"
end

function install_from_map(path, map)
  os.execute("mkdir -p " .. path .. "/bin")

  for source, dest in pairs(map) do
    os.execute("mv " .. path .. "/" .. source .. " " .. path .. "/bin/" .. dest)
    os.execute("chmod +x " .. path .. "/bin/" .. dest)
  end
end

function install_from_list(path, list)
  os.execute("mkdir -p " .. path .. "/bin")

  for _, binary in ipairs(list) do
    os.execute("mv " .. path .. "/" .. binary .. " " .. path .. "/bin/")
    os.execute("chmod +x " .. path .. "/bin/" .. binary)
  end
end
