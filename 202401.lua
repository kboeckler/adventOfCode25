local function distanceTo(leftNumber, i, rightNumbers)
	local rightNum = rightNumbers[i]
	local distance = rightNum - leftNumber
	if (distance < 0) then
		distance = -1 * distance
	end
	return distance
end

local function similarityTo(leftNumber, rightNumbers)
	local amountRight = 0
	for _, rn in ipairs(rightNumbers) do
		if rn == leftNumber then
			amountRight = amountRight + 1
		end
	end
	local similarity = (leftNumber * amountRight)
	return similarity
end

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
	sumDistance = sumDistance + distanceTo(leftNum, i, right)
	sumSimilarity = sumSimilarity + similarityTo(leftNum, right)
end
print("sumDistance: " .. sumDistance)
print("sumSimilarity: " .. sumSimilarity)
