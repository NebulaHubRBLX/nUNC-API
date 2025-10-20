printSection("📦 CONSOLE API • External Console Window Management")

test("rconsoleclear", {"consoleclear"}, nil, "Console")
test("rconsolecreate", {"consolecreate"}, nil, "Console")
test("rconsoledestroy", {"consoledestroy"}, nil, "Console")
test("rconsoleinput", {"consoleinput"}, nil, "Console")
test("rconsoleprint", {"consoleprint"}, nil, "Console")
test("rconsolesettitle", {"rconsolename", "consolesettitle"}, nil, "Console")