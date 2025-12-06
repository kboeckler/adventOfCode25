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
-- calculating
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
