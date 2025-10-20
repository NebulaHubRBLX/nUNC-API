local function colorPrint(color, text)
	if CONFIG.COLORS and CONFIG.COLORS[color] then
		print(CONFIG.COLORS[color] .. text .. CONFIG.COLORS.RESET)
	else
		print(text)
	end
end

local function printHeader(text, char)
	char = char or "="
	local padding = math.floor((70 - #text) / 2)
	colorPrint("INFO", string.rep(char, 70))
	colorPrint("BOLD", string.rep(" ", padding) .. text)
	colorPrint("INFO", string.rep(char, 70))
end

local function printSection(text)
	local colors = CONFIG.COLORS or {}
	local bold = colors.BOLD or ""
	local info = colors.INFO or ""
	local reset = colors.RESET or ""
	print("\n" .. bold .. info .. "╔" .. string.rep("═", 68) .. "╗" .. reset)
	print(bold .. info .. "║ " .. text .. string.rep(" ", 67 - #text) .. "║" .. reset)
	print(bold .. info .. "╚" .. string.rep("═", 68) .. "╝" .. reset .. "\n")
end