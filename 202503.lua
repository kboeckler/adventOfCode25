local function calcJoltageOfBank(bank, batteryAmount)
	local maxNumbers = {}
	local maxNumberIndices = {}
	for _ = 1, batteryAmount do
		table.insert(maxNumbers, 0)
		table.insert(maxNumberIndices, -1)
	end
	for currentNumber = 1, batteryAmount do
		local searchStart = 1
		if currentNumber > 1 then
			searchStart = maxNumberIndices[currentNumber - 1] + 1
		end
		local searchEnd = string.len(bank) - (batteryAmount - currentNumber)
		for i = searchStart, searchEnd do
			local num = tonumber(bank:sub(i, i)) or 0
			if num > maxNumbers[currentNumber] then
				maxNumbers[currentNumber] = num
				maxNumberIndices[currentNumber] = i
			end
		end
	end
	return tonumber(table.concat(maxNumbers)) or 0
end
local input = require("aoc").input(2025, 3)
local totalJoltage2 = 0
local totalJoltage12 = 0
for row in string.gmatch(input, "[^\n]+") do
	totalJoltage2 = totalJoltage2 + calcJoltageOfBank(row, 2)
	totalJoltage12 = totalJoltage12 + calcJoltageOfBank(row, 12)
end
print("totalJoltage2: " .. totalJoltage2)
print("totalJoltage12: " .. totalJoltage12)
