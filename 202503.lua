local input = require("aoc").input(2025, 3)
local totalJoltage = 0
for row in string.gmatch(input, "[^\n]+") do
	local maxFirst = 0
	local maxFirstIndex = -1
	for i = 1, string.len(row) - 1 do
		local num = tonumber(row:sub(i, i))
		if num > maxFirst then
			maxFirst = num
			maxFirstIndex = i
		end
	end
	local maxSecond = 0
	for i = maxFirstIndex + 1, #row do
		local num = tonumber(row:sub(i, i))
		if num > maxSecond then
			maxSecond = num
		end
	end
	local joltage = tonumber(maxFirst .. maxSecond)
	totalJoltage = totalJoltage + joltage
end
print("totalJoltage: " .. totalJoltage)
