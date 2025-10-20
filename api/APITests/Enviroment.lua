printSection("📦 ENVIRONMENT API • Garbage Collection & Environments")

test("getgc", {}, function()
	local gc = getgc()
	assert(type(gc) == "table", "Should return table")
	assert(#gc > 0, "Should not be empty")
	local functionCount = 0
	for _, v in ipairs(gc) do
		if type(v) == "function" then functionCount = functionCount + 1 end
	end
	return "Collected " .. #gc .. " objects (" .. functionCount .. " functions)"
end, "Environment")

test("getgenv", {}, function()
	getgenv().__TEST_GLOBAL_VAR = "test_value"
	assert(__TEST_GLOBAL_VAR == "test_value", "Global not set")
	assert(getgenv().__TEST_GLOBAL_VAR == "test_value", "Value mismatch")
	getgenv().__TEST_GLOBAL_VAR = nil
	return "Global environment access successful"
end, "Environment")

test("getreg", {}, function()
	local reg = getreg()
	assert(type(reg) == "table", "Should return table")
	assert(reg ~= _G, "Registry should differ from _G")
	return "Lua registry accessed successfully"
end, "Environment")

test("getrenv", {}, function()
	local renv = getrenv()
	assert(type(renv) == "table", "Should return table")
	assert(_G ~= renv._G, "Executor _G should differ from game _G")
	assert(renv.game == game, "Should have game reference")
	return "Roblox environment accessed successfully"
end, "Environment")

test("filtergc", {}, function()
	local functions = filtergc("function")
	assert(type(functions) == "table", "Should return table")
	assert(#functions > 0, "Should have functions")
	for _, v in ipairs(functions) do
		assert(type(v) == "function", "All items should be functions")
	end
	return "Filtered " .. #functions .. " functions from GC"
end, "Environment")