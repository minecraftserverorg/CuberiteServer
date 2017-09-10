Data = {}
Window = {}
Slots = nil
LocalDir = nil
PluginName = nil

function Initialize(Plugin)
  Plugin:SetName("Backpack")
  Plugin:SetVersion(1.1)

  LocalDir = Plugin:GetLocalFolder();

  if not (LoadData()) then
    LOG("[Backpack] Error: Reading file")
    LOG("[Backpack] - First start?")
  end

  PluginName = Plugin:GetName()

  dofile(cPluginManager:GetPluginsPath()  .. "/InfoReg.lua")
  RegisterPluginInfoCommands()
  LOG("Initialized " .. PluginName .. " v." .. Plugin:GetVersion())

  return true
end

function LoadData()
  Window = cLuaWindow(0, Backpack_Width , Backpack_Height, Backpack_Title)
  Slots = (Backpack_Width*Backpack_Height) - 1;
  Data = cIniFile()
  return Data:ReadFile(LocalDir .. '/' .. Backpack_File, true)
end

function OnDisable()
  LOG(PluginName .. " is shutting down...")

  if not (Data:Flush()) then
    LOG('[Backpack] Error: Writing file')
  end

  Data:Clear()
end
