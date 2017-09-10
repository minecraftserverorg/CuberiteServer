function Backpack(Split, Player)
  a_PlayerName = ''

  if(#Split == 1) then
    a_PlayerName =Player:GetName()
  else
    if not (Player:HasPermission("backpack.open.other")) then
      Player:SendMessageFailure("You do not have permission to use this command")
      return true
    end
    a_PlayerName = Split[2]
  end

 local isFound = Data:HasValue(a_PlayerName, '0')

 --
 local SaveItems = function(a_Window, a_Player, CanRefuse)
    if not (isFound) then
      Data:AddKeyName(a_PlayerName)
      for i = 0, Slots do
        Data:AddValue(a_PlayerName, tostring(i), ItemToFullString(a_Window:GetSlot(a_Player, i)))
      end
      a_Player:SendMessageInfo("The " .. a_PlayerName .. "'s backpack was created")
    else
      for i = 0, Slots do
        Data:SetValue(a_PlayerName, tostring(i), ItemToFullString(a_Window:GetSlot(a_Player, i)), true)
      end
    end

    return CanRefuse and false
  end
 --

  Window:SetOnClosing(SaveItems)

  if(isFound) then
    LoadItems(Window, Player)
  end

  Player:OpenWindow(Window);

  return true
end

function LoadItems(a_Window, a_Player)
  local Item = cItem()
  for i = 0, Slots do
    -- I had to use this because the other options(StringToItem()) did not work with count
    local str = StringSplit(Data:GetValue(a_PlayerName, tostring(i), ''), '*')
    --
    StringToItem(str[1], Item)
    Item.m_ItemCount = tonumber(str[2])
    a_Window:SetSlot(a_Player, i, Item)
  end
end

function ClearItems(Split, Player)
  a_PlayerName = ''
  if(Split[3] ~= nil) then
    if not (Player:HasPermission("backpack.clean.other")) then
        Player:SendMessageFailure("You do not have permission to use this command")
        return true
    end
    a_PlayerName = Split[3]
  else
    a_PlayerName = Player:GetName()
  end

--[[  Works only once due to implementation
  if not(Data:DeleteKey(a_PlayerName)) then
    LOG("Cleaning the backpack was not successful")
  end
  ]]

  local isFound = Data:HasValue(a_PlayerName, '0')

  if not (isFound) then
    Player:SendMessageFailure(a_PlayerName .. "'s backpack not found")
    return true
  end

  local EmptyItem = cItem()

  for i = 0, Slots do
    Data:SetValue(a_PlayerName, tostring(i), ItemToFullString(EmptyItem), true)
  end

  Player:SendMessageInfo(a_PlayerName .. "'s backpack cleaned")
  return true
end
