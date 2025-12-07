local input = require("aoc").input(2025, 6)
-- parsing
local operations = {}
for row in string.gmatch(input, "[^\n]+") do
	if string.find(row, "[\\*\\+]") ~= nil then
		local opIndex = 1
		for opChar in string.gmatch(row, "[\\*\\+]") do
			local operation = operations[opIndex]
			operation.operation = opChar
			opIndex = opIndex + 1
		end
	else
		local opIndex = 1
		for number in string.gmatch(row, "[%w]+") do
			if #operations < opIndex then
				table.insert(operations, {numbers={}, operation=nil})
			end
			local operation = operations[opIndex]
			table.insert(operation.numbers, tonumber(number))
			opIndex = opIndex + 1
		end
	end
end
-- calculating
local totalSum = 0
for _, operation in ipairs(operations) do
	local value = operation.numbers[1]
	for i=2,#operation.numbers do
		local number = operation.numbers[i]
		if operation.operation == "+" then
			value = value + number
		elseif operation.operation == "*" then
			value = value * number
		else
			print("ERROR")
		end
	end
	totalSum = totalSum + value
end
print("totalSum: " .. totalSum)
