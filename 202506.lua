local input = require("aoc").input(2025, 6)
-- parsing part 1
local simpleOperations = {}
local operationsRow = ""
local numberRows = {}
for row in string.gmatch(input, "[^\n]+") do
	if string.find(row, "[\\*\\+]") ~= nil then
		operationsRow = row
		local opIndex = 1
		for opChar in string.gmatch(operationsRow, "[*+]") do
			local operation = simpleOperations[opIndex]
			operation.operation = opChar
			opIndex = opIndex + 1
		end
	else
		table.insert(numberRows, row)
		local opIndex = 1
		for number in string.gmatch(row, "[%w]+") do
			if #simpleOperations < opIndex then
				table.insert(simpleOperations, {numbers={}, operation=nil})
			end
			local operation = simpleOperations[opIndex]
			table.insert(operation.numbers, tonumber(number))
			opIndex = opIndex + 1
		end
	end
end
-- parsing part 2
local complexOperations = {}
local operationIntervals = {}
local searchOpStart = 1
while true do
	local indexOfOp = string.find(operationsRow, "[*+]", searchOpStart)
	if indexOfOp ~= nil then
		if #operationIntervals > 0 then
			operationIntervals[#operationIntervals].to = indexOfOp - 2
		end
		table.insert(operationIntervals, {from=indexOfOp,to=0})
		searchOpStart = indexOfOp + 1
	else
		operationIntervals[#operationIntervals].to = #operationsRow
		break
	end
end
for _, interval in ipairs(operationIntervals) do
	local numbers = {}
	for pos=interval.from,interval.to do
		local numberArr = {}
		for i=1,#numberRows do
			local digit = string.sub(numberRows[i], pos, pos)
			numberArr[#numberArr+1] = digit
		end
		table.insert(numbers, tonumber(table.concat(numberArr)))
	end
	local opChar = string.sub(operationsRow, interval.from, interval.from)
	table.insert(complexOperations, {numbers=numbers, operation=opChar})
end
-- calculating
local function calculate(operations)
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
	return totalSum
end
print("simpleMath: " .. calculate(simpleOperations))
print("complexMath: " .. calculate(complexOperations))
