-- Quick settings
local Rules = "Do whatever you want! ;)"

-- General
function HandleActionBarBroadcastCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():ForEachPlayer(
			function(OtherPlayer)
				OtherPlayer:SendAboveActionBarMessage(Message)
			end
		)
	end
	return true
end

function HandleBroadcastCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		--local Message = table.concat(Split, " ", 2)--:gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		--cRoot:Get():BroadcastChat(cChatColor.Red .. "[BROADCAST] " .. cChatColor.Rose .. Message)
	end
	return true
end

function HandleClearChatCommand(Split, Player)
	for i=1,100 do
		cRoot:Get():BroadcastChat("")
	end
	cRoot:Get():BroadcastChatSuccess("The chat has been cleared")
	return true
end

function HandleConsoleCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local Message = table.concat(Split, " " , 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat(cChatColor.Gray .. "[CONSOLE] " .. cChatColor.White .. Message)
	end
	return true
end

function HandleDestroyentitiesCommand(Split, Player)
	cRoot:Get():QueueExecuteConsoleCommand("destroyentities")
	Player:SendMessageSuccess("Successfully destroyed all entities in every world")
	return true
end

function HandleEnchantAllCommand(Split, Player)
	if Player:GetEquippedItem():IsEmpty() then
		Player:SendMessageFailure("Please hold an item in your hand to enchant it")
	else
		Player:GetEquippedItem().m_Enchantments:AddFromString("0=1000;1=1000;2=1000;3=1000;4=1000;5=1000;6=1000;7=1000;8=1000;16=1000;17=1000;18=1000;19=1000;20=1000;21=125;32=1000;33=1000;34=1000;35=1000;48=1000;49=1000;50=1000;51=1000;61=1000;62=1000;70=1000;")
		Player:GetInventory():SetHotbarSlot(Player:GetInventory():GetEquippedSlotNum(), Player:GetEquippedItem())
		Player:SendMessageSuccess("You have all those enchantments now. ;)")
	end
	return true
end

function HandleFoodLevelCommand(Split, Player)
	local FoodLevel = function(OtherPlayer)
		OtherPlayer:SetFoodLevel(tonumber(Split[2]))
		OtherPlayer:SetFoodSaturationLevel(5)
		OtherPlayer:SetFoodExhaustionLevel(0)
		OtherPlayer:SendMessageInfo("Your food level has been set to " .. Player:GetFoodLevel())
		if Split[3] ~= nil and Split[3] ~= "*" and Split[3] ~= "**" then
			Player:SendMessageSuccess("Successfully set food level of player \"" .. OtherPlayer:GetName() .. "\" to " .. OtherPlayer:GetFoodLevel())
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <level> [player]")
	elseif Split[3] == nil then
		FoodLevel(Player)
	elseif Split[3] == "*" or Split[3] == "**" then
		cRoot:Get():ForEachPlayer(FoodLevel)
		Player:SendMessageSuccess("Successfully set food level of every player to " .. tonumber(Split[2]))
	elseif Player:HasPermission("extras.foodlevel.other") then
		if not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 3), FoodLevel) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 3) .. "\" not found")
		end
	end
	return true
end

function HandleImportSchematicCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <url>")
	else
		local URL = Split[2]
		local FileName = URL:match("([^/]+)$")
		if not string.find(URL, ".schematic",0,true) then
			Player:SendMessageFailure("The file has to be a schematic")
		elseif cFile:IsFile("schematics/" .. FileName) then
			Player:SendMessageFailure("A schematic with that name already exists")
		else
			os.execute("wget " .. URL .. " -P schematics/")
			Player:SendMessageSuccess("Imported schematic " .. FileName)
		end
	end
	return true
end

function HandleJumpscareCommand(Split, Player)
	local Jumpscare = function(OtherPlayer)
		local X = OtherPlayer:GetPosX()
		local Y = OtherPlayer:GetPosY()
		local Z = OtherPlayer:GetPosZ()
		OtherPlayer:GetWorld():BroadcastParticleEffect("mobappearance", X, Y, Z, 0, 0, 0, 1, 4)
		for i=1,10 do
			if OtherPlayer:GetClientHandle():GetProtocolVersion() <= 47 then
				OtherPlayer:GetClientHandle():SendSoundEffect("mob.endermen.scream", X, Y, Z, 1, 0)
			else
				OtherPlayer:GetClientHandle():SendSoundEffect("entity.endermen.scream", X, Y, Z, 1, 0)
			end
		end
		if not Split[2] == "*" or not Split[2] == "**" then
			Player:SendMessageSuccess("Successfully created jumpscare for player \"" .. OtherPlayer:GetName() .. "\"")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: ".. Split[1] .." <player>")
	elseif Split[2] == "*" or Split[2] == "**" then
		cRoot:Get():ForEachPlayer(Jumpscare)
		Player:SendMessageSuccess("Successfully created jumpscare for every player")
	elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Jumpscare) then
		Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) ..  "\" not found")
	end
	return true
end

function HandleKitCommand(Split, Player)
	local GiveKit = function(OtherPlayer)
		local function Info()
			OtherPlayer:SendMessageInfo("You have received kit \"" .. Split[2] .. "\"")
			if Split[3] ~= nil and Split[3] ~= "*" and Split[3] ~= "**" then
				Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to player \"" .. OtherPlayer:GetName() .. "\"")
			end
		end
		if Split[2] == "griefer" then
			for i=1,5 do
				OtherPlayer:GetInventory():AddItem(cItem(E_BLOCK_TNT, 64, 0, "", "§rKABOOM"))
			end
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_FLINT_AND_STEEL, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_LAVA_BUCKET, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_HELMET, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_CHESTPLATE, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_LEGGINGS, 1, 0))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_CHAIN_BOOTS, 1, 0))
			Info()
		elseif Split[2] == "op" then
			local Enchantments = "0=1000;1=1000;2=1000;3=1000;4=1000;5=1000;6=1000;7=1000;8=1000;16=1000;17=1000;18=1000;19=1000;20=1000;21=1000;32=1000;33=1000;34=1000;35=1000;48=1000;49=1000;50=0;51=1000;61=1000;62=1000;70=1000;"
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_SWORD, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_BOW, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_PICKAXE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_AXE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_SHOVEL, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_HOE, 1, 0, Enchantments))
			for i=1,2 do
				OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_ARROW, 64, 0))
			end
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_GOLDEN_APPLE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_HELMET, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_CHESTPLATE, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_LEGGINGS, 1, 0, Enchantments))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_DIAMOND_BOOTS, 1, 0, Enchantments))
			Info()
		elseif Split[2] == "weapons" then
			OtherPlayer:GetInventory():AddItem(cItem(E_BLOCK_ANVIL, 1, 0, "", "§8Anvil Dropper"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_BLAZE_ROD, 1, 0, "", "§6Nuker"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_STICK, 1, 0, "", "§fLightning Stick"))
			OtherPlayer:GetInventory():AddItem(cItem(E_ITEM_IRON_HORSE_ARMOR, 1, 0, "", "§7Sniper"))
			Info()
		else
			Player:SendMessageFailure("Invalid kit")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <name> [player]")
		Player:SendMessageInfo("Available kits: griefer, op, weapons")
	elseif Split[3] == nil then
		GiveKit(Player)
	elseif Player:HasPermission("extras.kit.other") then
		if Split[3] == "*" or Split[3] == "**" then
			cRoot:Get():ForEachPlayer(GiveKit)
			Player:SendMessageSuccess("Successfully gave kit \"" .. Split[2] .. "\" to every player")
		elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 3), GiveKit) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 3) .. "\" not found")
		end
	end
	return true
end

function HandleMeCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		local PlayerName
		if NickList[Player:GetUUID()] == nil then
			PlayerName = Player:GetName()
		else
			PlayerName = NickList[Player:GetUUID()]
		end
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat("* " .. PlayerName .. " " .. cChatColor.White .. Message)
	end
	return true
end

function HandleMemoryCommand(Split, Player)
	Player:SendMessageInfo("Current RAM usage: " .. math.floor(cRoot:GetPhysicalRAMUsage() / 1024 + 0.5) .. " MB")
	Player:SendMessageInfo("Current swap usage: " .. math.floor(cRoot:GetVirtualRAMUsage() / 1024 + 0.5) .. " MB")
	Player:SendMessageInfo("Total memory usage: " .. math.floor(cRoot:GetPhysicalRAMUsage() / 1024 + cRoot:GetVirtualRAMUsage() / 1024 + 0.5) .. " MB")
	Player:SendMessageInfo("Current loaded chunks: " .. cRoot:Get():GetTotalChunkCount())
	return true
end

function HandleNickCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <nickname ...>")
		return true
	elseif Split[2] == "off" then
		Player:SendMessageInfo("You no longer have a nickname")
		NickList[Player:GetUUID()] = nil
	else
		NickList[Player:GetUUID()] = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		Player:SendMessageSuccess("Successfully set your nickname to " .. NickList[Player:GetUUID()])
	end
	return true
end

function HandlePumpkinCommand(Split, Player)
	local Pumpkin = function(OtherPlayer)
		OtherPlayer:GetInventory():SetArmorSlot(0, cItem(E_BLOCK_PUMPKIN))
		if Split[2] ~= nil and Split[2] ~= "*" and Split[2] ~= "**" then
			Player:SendMessageSuccess("Player \"" .. OtherPlayer:GetName() .. "\" is now a pumpkin")
		end
	end
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	elseif Split[2] == "*" or Split[2] == "**" then
		cRoot:Get():ForEachPlayer(Pumpkin)
		Player:SendMessageSuccess("Everyone is now a pumpkin")
	elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Pumpkin) then
		Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) .. "\" not found")
	end
	return true
end

function HandleRestartCommand( Split, Player )
	cRoot:Get():BroadcastChat(cChatColor.Red .. "[WARNING] " .. cChatColor.White .. "Server is restarting!")
	return true
end

function HandleRulesCommand(Split, Player)
	Player:SendMessageInfo(Rules)
	return true
end

function HandleSpideyCommand(Split, Player)
	local World = Player:GetWorld()
	local WorldName = Player:GetWorld():GetName()
	local Callbacks = {
		OnNextBlock = function(BlockX, BlockY, BlockZ, BlockType, BlockMeta)
			if BlockType ~= E_BLOCK_AIR or WorldName == "hub" then
				return true
			end
			World:SetBlock(BlockX, BlockY, BlockZ, E_BLOCK_COBWEB, 0)
		end
	}
	local EyePos = Player:GetEyePosition()
	local LookVector = Player:GetLookVector()
	LookVector:Normalize()
	local Start = EyePos + LookVector + LookVector
	local End = EyePos + LookVector * 50
	cLineBlockTracer.Trace(World, Callbacks, Start.x, Start.y, Start.z, End.x, End.y, End.z)
	return true
end

function HandleStarveCommand(Split, Player)
	local Starve = function(OtherPlayer)
		OtherPlayer:SetFoodLevel(0)
		OtherPlayer:SendMessageSuccess("You are now starving")
		if Split[2] ~= nil and Split[2] ~= "*" and Split[2] ~= "**" then
			Player:SendMessageSuccess("Player \"" .. OtherPlayer:GetName() .. "\" is now starving")
		end
	end
	if Split[2] == nil then
		Starve(Player)
	elseif Player:HasPermission("extras.starve.other") then
		if Split[2] == "*" or Split[2] == "**" then
			cRoot:Get():ForEachPlayer(Starve)
			Player:SendMessageSuccess("Every player is now starving")
		elseif not cRoot:Get():FindAndDoWithPlayer(table.concat(Split, " ", 2), Starve) then
			Player:SendMessageFailure("Player \"" .. table.concat(Split, " ", 2) .. "\" not found")
		end
	end
	return true
end

function HandleSuicideCommand(Split, Player)
	Player:TakeDamage(dtInVoid, nil, 1000, 1000, 0)
	return true
end

function HandleTellrawCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <text ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():BroadcastChat(Message)
	end
	return true
end

function HandleTitleCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <text ...>")
	else
		local Message = table.concat(Split, " ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)

		cRoot:Get():ForEachPlayer(
			function(Player)
				Player:GetClientHandle():SendSetTitle(cCompositeChat():AddTextPart(Message))
				Player:GetClientHandle():SendSetSubTitle(cCompositeChat():AddTextPart(""))
				Player:GetClientHandle():SendTitleTimes(10, 160, 5)
			end
		)
	end
	return true
end

function HandleUnloadchunksCommand(Split, Player)
	cRoot:Get():SaveAllChunks()
	cRoot:Get():ForEachWorld(
		function(World)
			World:QueueUnloadUnusedChunks()
		end
	)
	Player:SendMessageSuccess("Successfully unloaded unused chunks")
	return true
end

function HandleUsernameCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <username ...>")
	elseif Split[2] == "off" then
		Player:SetCustomName(Player:GetClientHandle():GetUsername())
		Player:SetName(Player:GetClientHandle():GetUsername())
		Player:SendMessageSuccess("Successfully restored your original username \"" .. Player:GetClientHandle():GetUsername() .. "\"")
	else
		local Username = table.concat(Split," ", 2):gsub("&0", cChatColor.Black):gsub("&1", cChatColor.Navy):gsub("&2", cChatColor.Green):gsub("&3", cChatColor.Blue):gsub("&4", cChatColor.Red):gsub("&5", cChatColor.Purple):gsub("&6", cChatColor.Gold):gsub("&7", cChatColor.LightGray):gsub("&8", cChatColor.Gray):gsub("&9", cChatColor.DarkPurple):gsub("&a", cChatColor.LightGreen):gsub("&b", cChatColor.LightBlue):gsub("&c", cChatColor.Rose):gsub("&d", cChatColor.LightPurple):gsub("&e", cChatColor.Yellow):gsub("&f", cChatColor.White):gsub("&k", cChatColor.Random):gsub("&l", cChatColor.Bold):gsub("&m", cChatColor.Strikethrough):gsub("&n", cChatColor.Underlined):gsub("&o", cChatColor.Italic):gsub("&r", cChatColor.Plain)
	
		Player:SetName(Username)
		Player:SetCustomName(Username)
		Player:SendMessageSuccess("Successfully set your username to \"" .. Player:GetName() .. "\"")
	end
	return true
end

function HandleVoteCommand(Split, Player)
	Player:SendMessageInfo("Feel free to vote for the server to help it grow")
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[1] " ..cChatColor.LightGreen .. "TopG.org", "https://topg.org/Minecraft/in-414108"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[2] " ..cChatColor.LightGreen .. "MinecraftServers.org", "http://minecraftservers.org/vote/153833"))
	Player:SendMessage(cCompositeChat():AddUrlPart(cChatColor.Green.. "[3] " ..cChatColor.LightGreen .. "Minecraft Multiplayer", "http://minecraft-mp.com/server/155223/vote/"))
	return true 
end

-- Shortcuts
function HandleAdventureCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 2 " .. table.concat(Split, " ", 2))
	return true
end

function HandleClearinventoryCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/clear " .. table.concat(Split, " ", 2))
	return true
end

function HandleCreativeCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 1 " .. table.concat(Split, " ", 2))
	return true
end

function HandleDayCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/time set day")
	return true
end

function HandleEnchantmentCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> <enchantment ID> [level]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/enchant " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleIenchantmentCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <enchantment ID> [level]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/ienchant " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleKillallCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <type>")
		Player:SendMessageInfo("Acceptable types: monster, mob, itemframe, exporb, endercrystal, fallingblock, floater, minecart, entity, boat, pickup, tnt, painting, projectile")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/rem " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleMessageCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> <message ...>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tell " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleNightCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/time set night")
	return true
end

function HandleReplyCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <message ...>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/r " .. table.concat(Split, " ", 2))
	end
	return true 
end

function HandleSpectatorCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 3 " .. table.concat(Split, " ", 2))
	return true
end

function HandleSurvivalCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/gamemode 0 " .. table.concat(Split, " ", 2))
	return true
end

function HandleTeleCommand(Split, Player)
	if Split[2] == nil or #Split > 4 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player> [-h]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tp " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleTpohereCommand(Split, Player)
	if Split[2] == nil then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <player>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tphere " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleTpposCommand(Split, Player)
	if Split[2] == nil or #Split > 4 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " <x> <y> <z>")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/tp " .. table.concat(Split, " ", 2))
	end
	return true
end

function HandleWhoCommand(Split, Player)
	cPluginManager:Get():ExecuteCommand(Player, "/list " .. table.concat(Split, " ", 2))
	return true 
end

function HandleWorldCommand(Split, Player)
	if #Split > 2 then
		Player:SendMessageInfo("Usage: " .. Split[1] .. " [world]")
	else
		cPluginManager:Get():ExecuteCommand(Player, "/portal " .. table.concat(Split, " ", 2))
	end
	return true
end

-- Worlds
function HandleEndCommand(Split, Player)
	local World = cRoot:Get():GetWorld("end")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "end" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
	--	Player:MoveToWorld("end")
                        local World = cRoot:Get():GetWorld("end")
                        Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	end
	Player:SendMessageSuccess("Successfully moved to the End")
	return true
end

function HandleFlatlandsCommand(Split, Player)
	local World = cRoot:Get():GetWorld("flatlands")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "flatlands" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else--if Player:IsTicking() then
	--	Player:MoveToWorld("flatlands")
                        local World = cRoot:Get():GetWorld("flatlands")
                        Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	end
	Player:SendMessageSuccess("Successfully moved to the Flatlands")
	return true
end

function HandleHubCommand(Split, Player)
	local World = cRoot:Get():GetWorld("hub")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "hub" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
	--	Player:MoveToWorld("hub")
                        local World = cRoot:Get():GetWorld("hub")
                        Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	end
	Player:SendMessageSuccess("Successfully moved to the Hub")
	return true
end

function HandleNetherCommand(Split, Player)
	local World = cRoot:Get():GetWorld("nether")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "nether" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
	--	Player:MoveToWorld("nether")
                        local World = cRoot:Get():GetWorld("nether")
                        Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	end
	Player:SendMessageSuccess("Successfully moved to the Nether")
	return true
end

function HandleOverworldCommand(Split, Player)
	local World = cRoot:Get():GetWorld("overworld")
	Player:SetPitch(0)
	Player:SetYaw(0)
	if Player:GetWorld():GetName() == "overworld" then
		Player:TeleportToCoords(World:GetSpawnX(), World:GetSpawnY(), World:GetSpawnZ())
	else
	--	Player:MoveToWorld("overworld")
                        local World = cRoot:Get():GetWorld("overworld")
                        Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	--		Player:MoveToWorld("overworld")
	--		Player:MoveToWorld("overworld")
			-- Player:ScheduleMoveToWorld(World, Vector3d(World:GetSpawnX() + 0.5, World:GetSpawnY(), World:GetSpawnZ() + 0.5))
	end
	Player:SendMessageSuccess("Successfully moved to the Overworld")
	return true
end
