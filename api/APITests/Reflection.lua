printSection("📦 REFLECTION API • Property & Thread Manipulation")

test("gethiddenproperty", {}, function()
	local fire = Instance.new("Fire")
	local property, isHidden = gethiddenproperty(fire, "size_xml")
	assert(property == 5, "Property value should be 5")
	assert(isHidden == true, "Should identify as hidden")
	return "Retrieved hidden property 'size_xml'"
end, "Reflection")

test("getthreadidentity", {"getidentity", "getthreadcontext"}, function()
	local identity = getthreadidentity()
	assert(type(identity) == "number", "Should return number")
	return "Current thread identity: " .. identity
end, "Reflection")

test("isscriptable", {}, function()
	local fire = Instance.new("Fire")
	local sizeXmlScriptable = isscriptable(fire, "size_xml")
	local normalSizeScriptable = isscriptable(fire, "Size")
	assert(sizeXmlScriptable == false, "'size_xml' should not be scriptable")
	assert(normalSizeScriptable == true, "'Size' should be scriptable")
	return "Scriptable property detection works"
end, "Reflection")

test("sethiddenproperty", {}, function()
	local fire = Instance.new("Fire")
	local wasHidden = sethiddenproperty(fire, "size_xml", 10)
	assert(wasHidden, "Should return true for hidden property")
	local newValue = gethiddenproperty(fire, "size_xml")
	assert(newValue == 10, "Property not set correctly")
	return "Modified hidden property to 10"
end, "Reflection")

test("setscriptable", {}, function()
	local fire = Instance.new("Fire")
	local wasScriptable = setscriptable(fire, "size_xml", true)
	assert(wasScriptable == false, "Should return previous state (false)")
	assert(isscriptable(fire, "size_xml") == true, "Property not made scriptable")
	return "Property made scriptable successfully"
end, "Reflection")

test("setthreadidentity", {"setidentity", "setthreadcontext"}, function()
	local originalIdentity = getthreadidentity()
	setthreadidentity(3)
	local newIdentity = getthreadidentity()
	assert(newIdentity == 3, "Identity not set to 3")
	setthreadidentity(originalIdentity)
	return "Identity changed from " .. originalIdentity .. " to " .. newIdentity
end, "Reflection")