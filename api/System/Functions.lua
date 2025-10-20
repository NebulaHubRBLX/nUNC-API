local function getSystemInfo()
	local info = {
		gameId = "Unknown",
		jobId = "Unknown",
		placeId = "Unknown",
		placeName = "Unknown",
		players = 0,
		fps = 0,
		ping = 0,
		platform = "Unknown"
	}

	pcall(function() info.gameId = tostring(game.GameId) end)
	pcall(function() info.jobId = tostring(game.JobId) end)
	pcall(function() info.placeId = tostring(game.PlaceId) end)
	pcall(function()
		local marketplaceInfo = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
		info.placeName = marketplaceInfo.Name or "Unknown"
	end)
	pcall(function() info.players = #Players:GetPlayers() end)
	pcall(function() info.fps = math.floor(1 / RunService.RenderStepped:Wait()) end)
	pcall(function() info.ping = Players.LocalPlayer:GetNetworkPing() * 1000 end)
	pcall(function() info.platform = UserInputService.TouchEnabled and "Mobile" or "Desktop" end)
	
	return info
end