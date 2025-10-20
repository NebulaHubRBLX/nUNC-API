printSection("📦 SIGNALS API • Event Connection & Firing")

test("getconnections", {}, function()
	local requiredFields = {
		"Enabled", "ForeignState", "LuaConnection", "Function", 
		"Thread", "Fire", "Defer", "Disconnect", "Disable", "Enable"
	}
	local bindable = Instance.new("BindableEvent")
	bindable.Event:Connect(function() end)
	local connections = getconnections(bindable.Event)
	assert(#connections > 0, "Should have at least one connection")
	local connection = connections[1]
	for _, field in ipairs(requiredFields) do
		assert(connection[field] ~= nil, "Missing field: " .. field)
	end
	return "Retrieved connection with " .. #requiredFields .. " fields"
end, "Signals")

test("firesignal", {}, function()
	local bindable = Instance.new("BindableEvent")
	local fired = false
	bindable.Event:Connect(function()
		fired = true
	end)
	firesignal(bindable.Event)
	task.wait(0.1)
	assert(fired, "Signal should have fired")
	return "Signal fired successfully"
end, "Signals")

test("replicatesignal", {}, function()
	local bindable = Instance.new("BindableEvent")
	replicatesignal(bindable.Event)
	return "Signal replication initialized"
end, "Signals")

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

test("getfunctionhash", {}, function()
	local function testFunc1()
		print("test")
	end
	local function testFunc2()
		print("different")
	end
	local hash1 = getfunctionhash(testFunc1)
	local hash2 = getfunctionhash(testFunc1)
	local hash3 = getfunctionhash(testFunc2)
	assert(type(hash1) == "string", "Should return string")
	assert(hash1 == hash2, "Same function should have same hash")
	assert(hash1 ~= hash3, "Different functions should have different hashes")
	return "Function hashing works correctly"
end, "Scripts")

test("decompile", {}, function()
	local animate = Players.LocalPlayer.Character.Animate
	local source = decompile(animate)
	assert(type(source) == "string", "Should return string")
	assert(#source > 0, "Decompiled source should not be empty")
	return "Decompiled " .. #source .. " characters of source code"
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