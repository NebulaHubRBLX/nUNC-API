local function playerInfo()
	local Plrr = game.Players.LocalPlayer

	local info = {
		playerName = "Unknown",
		playerAge = "Unknown"
	}

	pcall(function() info.playerName = tostring(Plrr.Name) end)
	pcall(function() info.playerAge = tostring(Plrr.AccountAge) end)
	
	return info
end