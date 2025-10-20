printSection("📦 MISC API • Miscellaneous Utilities")

test("identifyexecutor", {"getexecutorname"}, function()
	local name, version = identifyexecutor()
	assert(type(name) == "string", "Name should be string")
	local versionInfo = version and (" v" .. version) or ""
	return "Identified as: " .. name .. versionInfo
end, "Misc")

test("lz4compress", {}, function()
	local raw = "Hello, world! This is a test string for compression."
	local compressed = lz4compress(raw)
	assert(type(compressed) == "string", "Compression should return string")
	local ratio = math.floor((#compressed / #raw) * 100)
	return "Compressed " .. #raw .. " bytes to " .. #compressed .. " (" .. ratio .. "%)"
end, "Misc")

test("lz4decompress", {}, function()
	local raw = "Hello, world! This is a test string for compression."
	local compressed = lz4compress(raw)
	local decompressed = lz4decompress(compressed, #raw)
	assert(decompressed == raw, "Decompression failed")
	return "Decompressed " .. #compressed .. " bytes back to " .. #raw
end, "Misc")

test("messagebox", {}, nil, "Misc")
test("queue_on_teleport", {"queueonteleport"}, nil, "Misc")

test("request", {"http.request", "http_request"}, function()
	local response = request({
		Url = "https://httpbin.org/user-agent",
		Method = "GET",
	})
	assert(type(response) == "table", "Response should be table")
	assert(response.StatusCode == 200, "Should return 200 OK")
	local data = HttpService:JSONDecode(response.Body)
	assert(type(data) == "table", "Response body should be JSON")
	return "HTTP request successful • " .. data["user-agent"]
end, "Misc")

test("setclipboard", {"toclipboard"}, nil, "Misc")

test("setfpscap", {}, function()
	local renderStepped = RunService.RenderStepped
	local function measureFPS()
		renderStepped:Wait()
		local sum = 0
		for _ = 1, 5 do
			sum = sum + 1 / renderStepped:Wait()
		end
		return math.round(sum / 5)
	end
	setfpscap(60)
	task.wait(0.1)
	local fps60 = measureFPS()
	setfpscap(0)
	task.wait(0.1)
	local fps0 = measureFPS()
	return fps60 .. " FPS @60 cap • " .. fps0 .. " FPS @unlimited"
end, "Misc")

test("getfpscap", {}, nil, "Misc")