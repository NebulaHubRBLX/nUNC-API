printSection("📦 DEBUG API • Function Introspection & Manipulation")

test("debug.getconstant", {}, function()
	local function testFunc()
		print("Hello, world!")
	end
	assert(debug.getconstant(testFunc, 1) == "print", "First constant must be 'print'")
	assert(debug.getconstant(testFunc, 2) == nil, "Second constant must be nil")
	assert(debug.getconstant(testFunc, 3) == "Hello, world!", "Third constant incorrect")
	return "Retrieved 3 constants successfully"
end, "Debug")

test("debug.getconstants", {}, function()
	local function testFunc()
		local num = 5000 .. 50000
		print("Hello, world!", num, warn)
	end
	local constants = debug.getconstants(testFunc)
	assert(constants[1] == 50000, "First constant should be 50000")
	assert(constants[2] == "print", "Second constant should be 'print'")
	return "Retrieved " .. #constants .. " constants from function"
end, "Debug")

test("debug.getinfo", {}, function()
	local expectedFields = {
		source = "string", short_src = "string", func = "function",
		what = "string", currentline = "number", name = "string",
		nups = "number", numparams = "number", is_vararg = "number"
	}
	local function testFunc(...) print(...) end
	local info = debug.getinfo(testFunc)
	for field, expectedType in pairs(expectedFields) do
		assert(info[field] ~= nil, "Missing field: " .. field)
		assert(type(info[field]) == expectedType, "Wrong type for " .. field)
	end
	return "All " .. #expectedFields .. " debug info fields present"
end, "Debug")

test("debug.getproto", {}, function()
	local function testFunc()
		local function innerProto() return true end
	end
	local proto = debug.getproto(testFunc, 1, true)[1]
	assert(proto, "Failed to get inner function")
	assert(proto() == true, "Inner function didn't return true")
	return "Successfully extracted inner function prototype"
end, "Debug")

test("debug.getprotos", {}, function()
	local function testFunc()
		local function _1() return true end
		local function _2() return true end
		local function _3() return true end
	end
	local protos = debug.getprotos(testFunc)
	assert(#protos == 3, "Should have 3 prototypes")
	for i in ipairs(protos) do
		local proto = debug.getproto(testFunc, i, true)[1]
		assert(proto(), "Failed to get inner function " .. i)
	end
	return "Extracted 3 function prototypes"
end, "Debug")

test("debug.getstack", {}, function()
	local _ = "a" .. "b"
	assert(debug.getstack(1, 1) == "ab", "First stack item should be 'ab'")
	assert(debug.getstack(1)[1] == "ab", "Stack table index incorrect")
	return "Stack access successful"
end, "Debug")

test("debug.getupvalue", {}, function()
	local upvalue = function() end
	local function testFunc() print(upvalue) end
	local retrieved = debug.getupvalue(testFunc, 1)
	assert(retrieved == upvalue, "Upvalue doesn't match")
	return "Upvalue retrieval successful"
end, "Debug")

test("debug.getupvalues", {}, function()
	local upvalue = function() end
	local function testFunc() print(upvalue) end
	local upvalues = debug.getupvalues(testFunc)
	assert(upvalues[1] == upvalue, "Upvalue doesn't match")
	return "Retrieved " .. #upvalues .. " upvalue(s)"
end, "Debug")

test("debug.setconstant", {}, function()
	local function testFunc() return "fail" end
	debug.setconstant(testFunc, 1, "success")
	assert(testFunc() == "success", "Constant not modified")
	return "Function constant successfully modified"
end, "Debug")

test("debug.setstack", {}, function()
	local function testFunc()
		return "fail", debug.setstack(1, 1, "success")
	end
	assert(testFunc() == "success", "Stack not modified")
	return "Stack value successfully modified"
end, "Debug")

test("debug.setupvalue", {}, function()
	local function upvalue() return "fail" end
	local function testFunc() return upvalue() end
	debug.setupvalue(testFunc, 1, function() return "success" end)
	assert(testFunc() == "success", "Upvalue not modified")
	return "Function upvalue successfully modified"
end, "Debug")