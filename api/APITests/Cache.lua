printSection("📦 CACHE API • Instance Reference Management")

test("cache.invalidate", {}, function()
	local container = Instance.new("Folder")
	local part = Instance.new("Part", container)
	cache.invalidate(container:FindFirstChild("Part"))
	assert(part ~= container:FindFirstChild("Part"), "Reference could not be invalidated")
	return "Successfully invalidated instance reference"
end, "Cache")

test("cache.iscached", {}, function()
	local part = Instance.new("Part")
	assert(cache.iscached(part), "Part should be cached")
	cache.invalidate(part)
	assert(not cache.iscached(part), "Part should not be cached after invalidation")
	return "Cache status detection works correctly"
end, "Cache")

test("cache.replace", {}, function()
	local part = Instance.new("Part")
	local fire = Instance.new("Fire")
	cache.replace(part, fire)
	assert(part ~= fire, "Part was not replaced with Fire")
	return "Successfully replaced instance in cache"
end, "Cache")

test("cloneref", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not equal original reference")
	clone.Name = "TestName"
	assert(part.Name == "TestName", "Clone should update original instance")
	return "Reference cloning works correctly"
end, "Cache")

test("compareinstances", {}, function()
	local part = Instance.new("Part")
	local clone = cloneref(part)
	assert(part ~= clone, "Clone should not equal original reference")
	assert(compareinstances(part, clone), "compareinstances should return true for cloned refs")
	return "Instance comparison works correctly"
end, "Cache")