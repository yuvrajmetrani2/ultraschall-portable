dofile(reaper.GetResourcePath().."/UserPlugins/ultraschall_api.lua")

filecount, files = ultraschall.GetAllFilenamesInPath(ultraschall.Api_Path.."/Scripts_Examples")

for i=1, filecount do
  reaper.AddRemoveReaScript(false, 0, files[i], true)
end
