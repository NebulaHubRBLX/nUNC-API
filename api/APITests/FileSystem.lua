printSection("📦 FILESYSTEM API • File & Folder Operations")

test("appendfile", {}, function()
	writefile(".tests/appendfile.txt", "su")
	appendfile(".tests/appendfile.txt", "cce")
	appendfile(".tests/appendfile.txt", "ss")
	local content = readfile(".tests/appendfile.txt")
	assert(content == "success", "File append failed")
	return "Appended 6 bytes across 2 operations"
end, "Filesystem")

test("delfile", {}, function()
	writefile(".tests/delfile.txt", "test")
	assert(isfile(".tests/delfile.txt"), "File should exist")
	delfile(".tests/delfile.txt")
	assert(isfile(".tests/delfile.txt") == false, "File not deleted")
	return "File deleted successfully"
end, "Filesystem")

test("delfolder", {}, function()
	makefolder(".tests/delfolder")
	assert(isfolder(".tests/delfolder"), "Folder should exist")
	delfolder(".tests/delfolder")
	assert(isfolder(".tests/delfolder") == false, "Folder not deleted")
	return "Folder deleted successfully"
end, "Filesystem")

test("getcustomasset", {}, function()
	writefile(".tests/getcustomasset.txt", "success")
	local contentId = getcustomasset(".tests/getcustomasset.txt")
	assert(type(contentId) == "string", "Should return string")
	assert(contentId:match("^rbxasset://"), "Should start with 'rbxasset://'")
	return "Generated custom asset URL"
end, "Filesystem")

test("isfile", {}, function()
	writefile(".tests/isfile.txt", "success")
	assert(isfile(".tests/isfile.txt") == true, "Should return true for file")
	assert(isfile(".tests") == false, "Should return false for folder")
	assert(isfile(".tests/nonexistent.txt") == false, "Should return false for nonexistent")
	return "File detection working correctly"
end, "Filesystem")

test("isfolder", {}, function()
	assert(isfolder(".tests") == true, "Should return true for folder")
	assert(isfolder(".tests/nonexistent") == false, "Should return false for nonexistent")
	return "Folder detection working correctly"
end, "Filesystem")

test("listfiles", {}, function()
	makefolder(".tests/listfiles")
	writefile(".tests/listfiles/test_1.txt", "success")
	writefile(".tests/listfiles/test_2.txt", "success")
	local files = listfiles(".tests/listfiles")
	assert(#files == 2, "Should list 2 files, got " .. #files)
	assert(isfile(files[1]), "First entry should be a file")
	return "Listed " .. #files .. " files in directory"
end, "Filesystem")

test("loadfile", {}, function()
	writefile(".tests/loadfile.txt", "return ... + 1")
	local result = assert(loadfile(".tests/loadfile.txt"))(1)
	assert(result == 2, "Loadfile arithmetic failed")
	writefile(".tests/loadfile.txt", "invalid syntax!")
	local callback, err = loadfile(".tests/loadfile.txt")
	assert(err and not callback, "Should return error for invalid syntax")
	return "File loading and execution successful"
end, "Filesystem")

test("makefolder", {}, function()
	makefolder(".tests/makefolder")
	assert(isfolder(".tests/makefolder"), "Folder not created")
	return "Directory created successfully"
end, "Filesystem")

test("readfile", {}, function()
	writefile(".tests/readfile.txt", "success")
	local content = readfile(".tests/readfile.txt")
	assert(content == "success", "File contents don't match")
	return "Read 7 bytes from file"
end, "Filesystem")

test("writefile", {}, function()
	writefile(".tests/writefile.txt", "success")
	local content = readfile(".tests/writefile.txt")
	assert(content == "success", "File not written correctly")
	return "Wrote 7 bytes to file"
end, "Filesystem")