local NAME = ...

local open = io.open

local function read_file(path)
	local file = open(path, "rb")
	if not file then
		return nil
	end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content
end

local function sum(a, b)
	return a+b
end

return {
	sum = sum,
	fread = read_file
}
