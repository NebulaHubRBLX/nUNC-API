printSection("📦 CLOSURES API • Function Manipulation & Hooking")

test("checkcaller", {}, function()
	assert(checkcaller(), "Main executor scope should return true")
	return "Caller verification works"
end, "Closures")

test("clonefunction", {}, function()
	local function testFunc()
		return "success"
	end
	local copy = clonefunction(testFunc)
	assert(testFunc() == copy(), "Clone should return same value as original")
	assert(testFunc ~= copy, "Clone should not equal original function")
	return "Function cloning successful"
end, "Closures")

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
end, "Closures")

test("hookfunction", {"replaceclosure"}, function()
	local function testFunc()
		return true
	end
	local ref = hookfunction(testFunc, function()
		return false
	end)
	assert(testFunc() == false, "Hooked function should return false")
	assert(ref() == true, "Original reference should return true")
	assert(testFunc ~= ref, "Should not be same reference")
	return "Function hooking successful"
end, "Closures")

test("hookmetamethod", {}, function()
	local object = setmetatable({}, { 
		__index = newcclosure(function() return false end), 
		__metatable = "Locked!" 
	})
	local originalRef = hookmetamethod(object, "__index", function() return true end)
	assert(object.test == true, "Metamethod hook failed")
	assert(originalRef() == false, "Original reference incorrect")
	return "Hooked __index metamethod successfully"
end, "Closures")

test("iscclosure", {}, function()
	assert(iscclosure(print) == true, "print should be identified as C closure")
	assert(iscclosure(function() end) == false, "Lua function should not be C closure")
	return "C closure detection works"
end, "Closures")

test("isexecutorclosure", {"checkclosure", "isourclosure"}, function()
	assert(isexecutorclosure(isexecutorclosure) == true, "Should return true for executor global")
	assert(isexecutorclosure(newcclosure(function() end)) == true, "Should return true for executor C closure")
	assert(isexecutorclosure(function() end) == true, "Should return true for executor Lua closure")
	assert(isexecutorclosure(print) == false, "Should return false for Roblox global")
	return "Executor closure detection works"
end, "Closures")

test("islclosure", {}, function()
	assert(islclosure(print) == false, "print should not be Lua closure")
	assert(islclosure(function() end) == true, "Lua function should be Lua closure")
	return "Lua closure detection works"
end, "Closures")

test("newcclosure", {}, function()
	local function testFunc()
		return true
	end
	local testC = newcclosure(testFunc)
	assert(testFunc() == testC(), "C closure should return same value")
	assert(testFunc ~= testC, "C closure should not equal original")
	assert(iscclosure(testC), "Result should be identified as C closure")
	return "C closure creation successful"
end, "Closures")

test("restorefunction", {}, function()
	local function testFunc()
		return "original"
	end
	local originalFunc = testFunc
	hookfunction(testFunc, function()
		return "hooked"
	end)
	assert(testFunc() == "hooked", "Hook should work")
	restorefunction(testFunc)
	assert(testFunc() == "original", "Function should be restored")
	return "Function restoration successful"
end, "Closures")