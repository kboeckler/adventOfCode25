local input = require("aoc").input(2025, 5)
-- parsing
local ranges = {}
local ingredients = {}
local blankLineStart, blankLineEnd = string.find(input, "\n\n")
local rangesBlock = string.sub(input, 1, blankLineStart - 1)
local ingredientsBlock = string.sub(input, blankLineEnd + 1)
for range in string.gmatch(rangesBlock, "[^\n]+") do
	local dashPos = string.find(range, "-")
	local begin = string.sub(range, 1, dashPos - 1)
	local ending = string.sub(range, dashPos + 1)
	table.insert(ranges, {from=tonumber(begin), to=tonumber(ending)})
end
for ing in string.gmatch(ingredientsBlock, "[^\n]+") do
	table.insert(ingredients, tonumber(ing))
end
-- calculating part 1
local freshCount = 0
for _, ing in ipairs(ingredients) do
	local inAnyRange = false
	for _, range in ipairs(ranges) do
		if ing >= range.from and ing <= range.to then
			inAnyRange = true
			break
		end
	end
	if inAnyRange then
		freshCount = freshCount + 1
	end
end
print("freshCount: " .. freshCount)
-- calculating part 2
table.sort(ranges, function(a, b) return a.from < b.from end)
local currentRanges = ranges
local nextRanges = {}
local oneMoreTime = true
while oneMoreTime do
	oneMoreTime = false
	for _, range in ipairs(currentRanges) do
		range.used = false
	end
	for i, range in ipairs(currentRanges) do
		if not range.used then
			for j=i+1,#currentRanges do
				local otherRange = currentRanges[j]
				if not (otherRange.from > range.to) then
					if otherRange.to <= range.to then
						table.insert(nextRanges, range)
						range.used = true
						otherRange.used = true
					else
						table.insert(nextRanges, {from=range.from, to=otherRange.to, used=true})
						range.used = true
						otherRange = true
					end
					oneMoreTime = true
					break
				end
			end
			if not range.used then
				table.insert(nextRanges, range)
				range.used = true
			end
		end
	end
	currentRanges = nextRanges
	nextRanges = {}
end
local intervalSum = 0
for _, range in ipairs(currentRanges) do
	local intervalSize = range.to - range.from + 1
	intervalSum = intervalSum + intervalSize
end
print("intervalSum: " .. intervalSum)
