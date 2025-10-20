printSection("📦 WEBSOCKET API • Real-Time Network Communication")

test("WebSocket", {}, nil, "WebSocket")

test("WebSocket.connect", {}, function()
	local requiredMethods = {"Send", "Close"}
	local requiredEvents = {"OnMessage", "OnClose"}

	local ws = WebSocket.connect("wss://echo.websocket.events")
	assert(type(ws) == "table" or type(ws) == "userdata", "Should return table or userdata")

	for _, method in ipairs(requiredMethods) do
		assert(ws[method] ~= nil, "Missing method: " .. method)
		assert(type(ws[method]) == "function", method .. " should be function")
	end

	for _, event in ipairs(requiredEvents) do
		assert(ws[event] ~= nil, "Missing event: " .. event)
	end
	
	-- Test OnMessage event
	local messageReceived = false
	ws.OnMessage:Connect(function(message)
		messageReceived = true
	end)

	ws:Send("test")
	task.wait(0.5)

	local closeTriggered = false
	ws.OnClose:Connect(function()
		closeTriggered = true
	end)
	ws:Close()
	task.wait(0.1)
	
	assert(closeTriggered, "OnClose event should have triggered")
	return "WSS connection tested (secure WebSocket support confirmed)"
end, "WebSocket")