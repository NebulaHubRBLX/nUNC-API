printSection("📦 SCRIPTS API • Script Analysis & Manipulation")

test("getcallingscript", {}, nil, "Scripts")

test("getloadedmodules", {}, function()
	local modules = getloadedmodules()
	assert(type(modules) == "table", "Should return table")
	assert(#modules > 0, "Should have modules")
	assert(typeof(modules[1]) == "Instance", "Should be Instance")
	assert(modules[1]:IsA("ModuleScript"), "Should be ModuleScript")
	return "Retrieved " .. #modules .. " loaded modules"
end, "Scripts")

test("getrunningscripts", {}, function()
	local scripts = getrunningscripts()
	assert(type(scripts) == "table", "Should return table")
	assert(#scripts > 0, "Should have running scripts")
	assert(typeof(scripts[1]) == "Instance", "Should be Instance")
	return "Found " .. #scripts .. " running scripts"
end, "Scripts")

test("getscriptbytecode", {"dumpstring"}, function()
	local animate = Players.LocalPlayer.Character.Animate
	local bytecode = getscriptbytecode(animate)
	assert(type(bytecode) == "string", "Should return string")
	assert(#bytecode > 0, "Bytecode should not be empty")
	return "Dumped " .. #bytecode .. " bytes of bytecode"
end, "Scripts")

test("getscriptclosure", {"getscriptfunction"}, function()
	local module = game:GetService("CoreGui").RobloxGui.Modules.Common.Constants
	local constants = getrenv().require(module)
	local generated = getscriptclosure(module)()
	assert(constants ~= generated, "Generated module should not match original reference")
	assert(shallowEqual(constants, generated), "Tables should be shallow equal")
	return "Script closure extraction works"
end, "Scripts")

test("getscripthash", {}, function()
	local animate = Players.LocalPlayer.Character.Animate:Clone()
	local originalHash = getscripthash(animate)
	local originalSource = animate.Source
	animate.Source = "print('Modified!')"
	local modifiedHash = getscripthash(animate)
	animate.Source = originalSource
	local restoredHash = getscripthash(animate)
	assert(originalHash ~= modifiedHash, "Hash should change when source changes")
	assert(originalHash == restoredHash, "Hash should be consistent")
	return "Script hashing working correctly"
end, "Scripts")

test("getscripts", {}, function()
	local scripts = getscripts()
	assert(type(scripts) == "table", "Should return table")
	assert(#scripts > 0, "Should have scripts")
	local localScripts = 0
	local moduleScripts = 0
	for _, script in ipairs(scripts) do
		if script:IsA("LocalScript") then localScripts = localScripts + 1 end
		if script:IsA("ModuleScript") then moduleScripts = moduleScripts + 1 end
	end
	return #scripts .. " scripts (" .. localScripts .. " LS, " .. moduleScripts .. " MS)"
end, "Scripts")

test("getsenv", {}, function()
	local animate = Players.LocalPlayer.Character.Animate
	local env = getsenv(animate)
	assert(type(env) == "table", "Should return table")
	assert(env.script == animate, "Should have script reference")
	local keyCount = 0
	for _ in pairs(env) do keyCount = keyCount + 1 end
	return "Script environment has " .. keyCount .. " variables"
end, "Scripts")

test("loadstring", {}, function()
	assert(assert(loadstring("return ... + 1"))(1) == 2, "Failed simple arithmetic")
	local callback, err = loadstring("invalid syntax!")
	assert(err and not callback, "Should return error for compiler error")
	return "String loading and compilation works"
end, "Scripts")