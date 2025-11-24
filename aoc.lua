local NAME = ...

local open = io.open

---@return string
local function read_file(path)
	local file = open(path, "rb")
	if not file then
		error("Could not read file: " .. path)
	end
	local content = file:read "*a" -- *a or *all reads the whole file
	file:close()
	return content
end

---@return string
local function input(year, day)
	return read_file(".input/" .. year .. "/" .. day .. ".txt")
end

return {
	input = input
}
