local input = require("aoc").input(2025, 1)
-- parsing
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
-- calculating
local countZeroDials = 0
local clicks = 0
local dialValue = 50 + 100000
for _, change in ipairs(changes) do
	local oldDialValue = dialValue
	local newDialValue = dialValue + change
	dialValue = newDialValue
	if math.fmod(dialValue, 100) == 0 then
		countZeroDials = countZeroDials + 1
	end
	local oldClickFits = math.floor(oldDialValue / 100)
	local newClickFits = math.floor(newDialValue / 100)
	clicks = clicks + math.abs(newClickFits - oldClickFits)
	if change < 0 and math.fmod(dialValue, 100) == 0 then
		clicks = clicks + 1
	end
	if change < 0 and math.fmod(oldDialValue, 100) == 0 then
		clicks = clicks - 1
	end
end
print("countZeroDials: " .. countZeroDials)
print("clicks: " .. clicks)
