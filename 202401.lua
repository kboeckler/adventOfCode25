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
for _, num in ipairs(left) do
	print(num)
end
for _, num in ipairs(right) do
	print(num)
end
