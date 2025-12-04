local input = require("aoc").input(2025, 2)
-- parsing
local ids = {}
for range in string.gmatch(input, "[^\\,]+") do
	for rangeStart, rangeEnd in string.gmatch(range, "(%w+)-(%w+)") do
		local rangeStartNum = tonumber(rangeStart)
		local rangeEndNum = tonumber(rangeEnd)
		for i = rangeStartNum, rangeEndNum do
			table.insert(ids, i)
		end
	end
end
-- calculating
local function isPatternInvalidSplitBy(pattern, divisor)
	local length = string.len(pattern)
	if math.fmod(length, divisor) == 0 then
		local partLength = length / divisor
		local lastPart = nil
		for i=0,divisor-1 do
			local part = string.sub(pattern, 1 + partLength * i, partLength + partLength * i)
			if lastPart == nil or lastPart == part then
				lastPart = part
			else
				return false
			end
		end
		return true
	end
	return false
end
local function calcInvalidIds(divisors)
	local sumInvalidIds = 0
	for _, id in ipairs(ids) do
		local pattern = tostring(id)
		local oneDivisorLeadsToInvalid = false
		for _, divisor in ipairs(divisors) do
			if isPatternInvalidSplitBy(pattern, divisor) then
				oneDivisorLeadsToInvalid = true
				break
			end
		end
		if oneDivisorLeadsToInvalid then
			sumInvalidIds = sumInvalidIds + id
		end
	end
	return sumInvalidIds
end
print("sumInvalidIdsPart1: " .. calcInvalidIds({2}))
print("sumInvalidIdsPart2: " .. calcInvalidIds({2, 3, 4, 5, 6, 7, 8, 9, 10}))
