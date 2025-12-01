local input = require("aoc").input(2025, 1)
local changes = {}
for row in string.gmatch(input, "[^\n]+") do
	local leading = string.sub(row, 1, 1)
	local left = true
	if leading == "R" then
		left = false
	end

	local payload = string.sub(row, 2)
	local ticks = tonumber(payload)

	local change = ticks
	if left then
		change = -1 * change
	end

	table.insert(changes, change)
end
local countZeroDials = 0
local dialValue = 50 + 10000
for _, change in ipairs(changes) do
	dialValue = dialValue + change
	if math.fmod(dialValue, 100) == 0 then
		countZeroDials = countZeroDials + 1
	end
end
print("countZeroDials: " .. countZeroDials)
