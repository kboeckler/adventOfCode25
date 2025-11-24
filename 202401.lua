local input = require("aoc").input(2024, 1)
local left = {}
local right = {}
for row in string.gmatch(input, "[^\n]+") do
	local i = 0
	for number in string.gmatch(row, "%w+") do
		if i == 0 then
			table.insert(left, number)
		else
			table.insert(right, number)
		end
		i = i + 1
	end
end
table.sort(left)
table.sort(right)
local sumDistance = 0
local sumSimilarity = 0
for i, leftNum in ipairs(left) do
	local rightNum = right[i]
	local distance = rightNum - leftNum
	if (distance < 0) then
		distance = -1 * distance
	end
	sumDistance = sumDistance + distance
	local amountRight = 0
	for _, rn in ipairs(right) do
		if rn == leftNum then
			amountRight = amountRight + 1
		end
	end
	sumSimilarity = sumSimilarity + (leftNum * amountRight)
end
print("sumDistance: " .. sumDistance)
print("sumSimilarity: " .. sumSimilarity)
