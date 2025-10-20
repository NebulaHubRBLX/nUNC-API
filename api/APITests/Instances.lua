printSection("📦 INSTANCES API • Game Instance Manipulation")

test("cloneref", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not equal original reference")
	clone.Name = "TestName"
	assert(part.Name == "TestName", "Clone should update original instance")
	return "Reference cloning works correctly"
end, "Instances")

test("compareinstances", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not equal original reference")
	assert(compareinstances(part, clone), "compareinstances should return true for cloned refs")
	return "Instance comparison works correctly"
end, "Instances")

test("fireclickdetector", {}, function()
	local detector = Instance.new("ClickDetector")
	fireclickdetector(detector, 50, "MouseHoverEnter")
	return "ClickDetector fired successfully"
end, "Instances")

test("fireproximityprompt", {}, function()
	local prompt = Instance.new("ProximityPrompt")
	fireproximityprompt(prompt)
	return "ProximityPrompt triggered successfully"
end, "Instances")

test("firetouchinterest", {}, function()
	local part1 = Instance.new("Part")
	local part2 = Instance.new("Part")
	part1.Touched:Connect(function() end)
	firetouchinterest(part1, part2, 0)
	firetouchinterest(part1, part2, 1)
	return "Touch interest fired (touch + untouch)"
end, "Instances")

test("getcallbackvalue", {}, function()
	local bindable = Instance.new("BindableFunction")
	local function testFunc() end
	bindable.OnInvoke = testFunc
	local callback = getcallbackvalue(bindable, "OnInvoke")
	assert(callback == testFunc, "Callback value doesn't match")
	return "Callback retrieved successfully"
end, "Instances")

test("gethui", {}, function()
	local hui = gethui()
	assert(typeof(hui) == "Instance", "Should return Instance")
	assert(hui:IsA("Instance"), "Should be valid Instance")
	return "Hidden UI container: " .. hui.ClassName
end, "Instances")

test("getinstances", {}, function()
	local instances = getinstances()
	assert(type(instances) == "table", "Should return table")
	assert(#instances > 0, "Should have instances")
	assert(instances[1]:IsA("Instance"), "First entry should be Instance")
	return "Retrieved " .. #instances .. " game instances"
end, "Instances")

test("getnilinstances", {}, function()
	local nilInstances = getnilinstances()
	assert(type(nilInstances) == "table", "Should return table")
	assert(#nilInstances > 0, "Should have nil instances")
	assert(nilInstances[1]:IsA("Instance"), "Should be Instance")
	assert(nilInstances[1].Parent == nil, "Should be parented to nil")
	return "Retrieved " .. #nilInstances .. " nil-parented instances"
end, "Instances")