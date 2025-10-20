printSection("📦 ENCODING API • Data Encoding & Compression")

test("base64encode", {"base64_encode"}, function()
	local encoded = base64encode("test")
	assert(encoded == "dGVzdA==", "Base64 encoding failed")
	return "Encoded 'test' to 'dGVzdA=='"
end, "Encoding")

test("base64decode", {"base64_decode"}, function()
	local decoded = base64decode("dGVzdA==")
	assert(decoded == "test", "Base64 decoding failed")
	return "Decoded 'dGVzdA==' to 'test'"
end, "Encoding")

test("lz4compress", {}, function()
	local raw = "Hello, world! This is a test string for compression."
	local compressed = lz4compress(raw)
	assert(type(compressed) == "string", "Compression should return string")
	local ratio = math.floor((#compressed / #raw) * 100)
	return "Compressed " .. #raw .. " bytes to " .. #compressed .. " (" .. ratio .. "%)"
end, "Encoding")

test("lz4decompress", {}, function()
	local raw = "Hello, world! This is a test string for compression."
	local compressed = lz4compress(raw)
	local decompressed = lz4decompress(compressed, #raw)
	assert(decompressed == raw, "Decompression failed")
	return "Decompressed " .. #compressed .. " bytes back to " .. #raw
end, "Encoding")

test("crypt.decrypt", {}, function()
	local key, iv = crypt.generatekey(), crypt.generatekey()
	local encrypted = crypt.encrypt("test", key, iv, "CBC")
	local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
	assert(decrypted == "test", "Failed to decrypt")
	return "Decryption successful"
end, "Crypt")

test("crypt.generatebytes", {}, function()
	local size = math.random(10, 100)
	local bytes = crypt.generatebytes(size)
	local decoded = crypt.base64decode(bytes)
	assert(#decoded == size, "Generated " .. #decoded .. " bytes, expected " .. size)
	return "Generated " .. size .. " random bytes"
end, "Crypt")

test("crypt.generatekey", {}, function()
	local key = crypt.generatekey()
	local decoded = crypt.base64decode(key)
	assert(#decoded == 32, "Key should be 32 bytes, got " .. #decoded)
	return "Generated 256-bit encryption key"
end, "Crypt")

test("crypt.hash", {}, function()
	local algorithms = {'sha1', 'sha384', 'sha512', 'md5', 'sha256', 'sha3-224', 'sha3-256', 'sha3-512'}
	local testedAlgos = {}
	for _, algorithm in ipairs(algorithms) do
		local hash = crypt.hash("test", algorithm)
		assert(hash, "Hash failed for algorithm: " .. algorithm)
		table.insert(testedAlgos, algorithm)
	end
	return "Tested " .. #testedAlgos .. " hash algorithms"
end, "Crypt")

test("crypt.encrypt", {}, function()
	local key = crypt.generatekey()
	local encrypted, iv = crypt.encrypt("test", key, nil, "CBC")
	assert(iv, "Should return initialization vector")
	local decrypted = crypt.decrypt(encrypted, key, iv, "CBC")
	assert(decrypted == "test", "Failed to decrypt encrypted data")
	return "AES-CBC encryption/decryption successful"
end, "Crypt")

test("crypt.hash", {}, function()
	local algorithms = {'sha1', 'sha384', 'sha512', 'md5', 'sha256', 'sha3-224', 'sha3-256', 'sha3-512'}
	local testedAlgos = {}
	for _, algorithm in ipairs(algorithms) do
		local hash = crypt.hash("test", algorithm)
		assert(hash, "Hash failed for algorithm: " .. algorithm)
		table.insert(testedAlgos, algorithm)
	end
	return "Tested " .. #testedAlgos .. " hash algorithms"
end, "Crypt")