printSection("📦 METATABLE API • Table Metatable Manipulation")

test("getrawmetatable", {}, function()
	local metatable = { __metatable = "Locked!" }
	local object = setmetatable({}, metatable)
	local retrieved = getrawmetatable(object)
	assert(retrieved == metatable, "Metatable doesn't match")
	return "Bypassed locked metatable successfully"
end, "Metatable")

test("hookmetamethod", {}, function()
	local object = setmetatable({}, { 
		__index = newcclosure(function() return false end), 
		__metatable = "Locked!" 
	})
	local originalRef = hookmetamethod(object, "__index", function() return true end)
	assert(object.test == true, "Metamethod hook failed")
	assert(originalRef() == false, "Original reference incorrect")
	return "Hooked __index metamethod successfully"
end, "Metatable")

test("getnamecallmethod", {}, function()
	local capturedMethod
	local originalNamecall
	originalNamecall = hookmetamethod(game, "__namecall", function(...)
		if not capturedMethod then 
			capturedMethod = getnamecallmethod() 
		end
		return originalNamecall(...)
	end)
	game:GetService("Lighting")
	assert(capturedMethod == "GetService", "Should capture 'GetService' method")
	return "Captured namecall method: " .. capturedMethod
end, "Metatable")

test("isreadonly", {}, function()
	local mutableTable = {}
	local frozenTable = table.freeze({})
	assert(isreadonly(mutableTable) == false, "Mutable table should not be readonly")
	assert(isreadonly(frozenTable) == true, "Frozen table should be readonly")
	return "Readonly detection works correctly"
end, "Metatable")

test("setrawmetatable", {}, function()
	local object = setmetatable({}, { 
		__index = function() return false end, 
		__metatable = "Locked!" 
	})
	setrawmetatable(object, { __index = function() return true end })
	assert(object.test == true, "Metatable not changed")
	return "Raw metatable modification successful"
end, "Metatable")

test("setreadonly", {}, function()
	local object = { success = false }
	table.freeze(object)
	assert(isreadonly(object), "Table should be readonly")
	setreadonly(object, false)
	object.success = true
	assert(object.success == true, "Table still readonly")
	return "Successfully unfroze readonly table"
end, "Metatable")