printSection("📦 DRAWING API • 2D Rendering & Graphics")

test("Drawing", {}, nil, "Drawing")

test("Drawing.new", {}, function()
	local drawing = Drawing.new("Square")
	drawing.Visible = false
	drawing.Size = Vector2.new(100, 100)
	drawing.Position = Vector2.new(50, 50)
	drawing.Color = Color3.new(1, 0, 0)
	local canDestroy = pcall(function()
		drawing:Destroy()
	end)
	assert(canDestroy, "Drawing:Destroy() should not error")
	return "Created and destroyed Square drawing object"
end, "Drawing")

test("Drawing.Fonts", {}, function()
	local fonts = {"UI", "System", "Plex", "Monospace"}
	local expectedIds = {0, 1, 2, 3}
	for i, font in ipairs(fonts) do
		assert(Drawing.Fonts[font] == expectedIds[i], font .. " ID incorrect")
	end
	return "All 4 font IDs verified"
end, "Drawing")

test("isrenderobj", {}, function()
	local drawing = Drawing.new("Image")
	drawing.Visible = true
	assert(isrenderobj(drawing) == true, "Drawing should be render object")
	assert(isrenderobj(newproxy()) == false, "Userdata should not be render object")
	assert(isrenderobj({}) == false, "Table should not be render object")
	drawing:Destroy()
	return "Render object detection works"
end, "Drawing")

test("getrenderproperty", {}, function()
	local drawing = Drawing.new("Square")
	drawing.Visible = true
	drawing.Transparency = 0.5
	local visible = getrenderproperty(drawing, "Visible")
	local transparency = getrenderproperty(drawing, "Transparency")
	assert(type(visible) == "boolean", "Visible should be boolean")
	assert(type(transparency) == "number", "Transparency should be number")
	assert(visible == true, "Visible value incorrect")
	assert(transparency == 0.5, "Transparency value incorrect")
	drawing:Destroy()
	return "Retrieved Visible and Transparency properties"
end, "Drawing")

test("setrenderproperty", {}, function()
	local drawing = Drawing.new("Square")
	drawing.Visible = true
	setrenderproperty(drawing, "Visible", false)
	assert(drawing.Visible == false, "Property not set")
	setrenderproperty(drawing, "Transparency", 0.8)
	assert(drawing.Transparency == 0.8, "Transparency not set")
	drawing:Destroy()
	return "Modified 2 render properties successfully"
end, "Drawing")

test("cleardrawcache", {}, function()
	-- Create some drawings
	for i = 1, 5 do
		local d = Drawing.new("Line")
		d.Visible = false
	end
	cleardrawcache()
	return "Drawing cache cleared"
end, "Drawing")