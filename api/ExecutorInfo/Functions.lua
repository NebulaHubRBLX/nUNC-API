local function identifyExecutor()
	local executorData = {
		name = "Unknown",
		version = nil,
		type = "Unknown",
		features = {}
	}

	pcall(function()
		if identifyexecutor then
			local success, name, version = pcall(identifyexecutor)
			if success and name then
				executorData.name = name
				executorData.version = version
			end
		end
	end)

	if executorData.name == "Unknown" then
		pcall(function()
			if getexecutorname then
				local success, name = pcall(getexecutorname)
				if success and name then executorData.name = name end
			elseif KRNL_LOADED then executorData.name = "KRNL"
			elseif OXYGEN_LOADED then executorData.name = "Oxygen U"
			elseif syn then executorData.name = "Synapse X"
			elseif SONA_LOADED then executorData.name = "Sona"
			elseif secure_load then executorData.name = "Sentinel"
			elseif is_sirhurt_closure then executorData.name = "SirHurt"
			elseif Fluxus then executorData.name = "Fluxus"
			elseif iselectronexecutor then executorData.name = "Electron"
			elseif Celestia then executorData.name = "Celestia"
			elseif PROTOSMASHER_LOADED then executorData.name = "ProtoSmasher"
			elseif Wave then executorData.name = "Wave"
			elseif is_sirhurt_closure then executorData.name = "SirHurt"
			elseif TRIGON_LOADED then executorData.name = "Trigon"
			elseif Arceus then executorData.name = "Arceus X"
			elseif Evon then executorData.name = "Evon"
			elseif Nezur then executorData.name = "Nezur"
			elseif Codex then executorData.name = "Codex"
			elseif Delta then executorData.name = "Delta"
			elseif Hydrogen then executorData.name = "Hydrogen"
			end
		end)
	end
	
	-- Detect executor type thing idfk gng
	pcall(function()
		if syn or is_synapse_function then
			executorData.type = "Synapse"
		elseif KRNL_LOADED then
			executorData.type = "KRNL"
		elseif getexecutorname then
			executorData.type = "Modern"
		else
			executorData.type = "Legacy"
		end
	end)

	pcall(function()
		if getfenv and setfenv then
			table.insert(executorData.features, "Environment Control")
		end
	end)
	pcall(function()
		if debug and debug.getupvalue then
			table.insert(executorData.features, "Advanced Debugging")
		end
	end)
	pcall(function()
		if request or http_request then
			table.insert(executorData.features, "HTTP Requests")
		end
	end)
	pcall(function()
		if WebSocket then
			table.insert(executorData.features, "WebSocket Support")
		end
	end)
	pcall(function()
		if Drawing then
			table.insert(executorData.features, "Drawing Library")
		end
	end)
	
	return executorData
end