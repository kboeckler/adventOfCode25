local input = require("aoc").input(2025, 4)
-- parsing
local grid = {}
for row in string.gmatch(input, "[^\n]+") do
	local cells = {}
	for cell in row:gmatch"." do
		---@class Cell
		local myCell = {paper=false, neighbors=0}
		if cell == '@' then
			myCell.paper = true
		end
		table.insert(cells, myCell)
	end
	table.insert(grid, cells)
end
-- calculating
local width = #grid[1]
local height = #grid
local function removePapers(removeCellFromGrid, breakCondition)
	for _, row in ipairs(grid) do
		for _, cell in ipairs(row) do
			cell.neighbors = 0
		end
	end
	for y, row in ipairs(grid) do
		for x, cell in ipairs(row) do
			if cell.paper == true then
				for dx = -1, 1 do
					for dy = -1, 1 do
						local neighborX = x + dx
						local neighborY = y + dy
						if not (dx == 0 and dy == 0) and neighborX >= 1 and neighborX <= width and neighborY >= 1 and neighborY <= height then
							grid[neighborY][neighborX].neighbors = grid[neighborY][neighborX].neighbors + 1
						end
					end
				end
			end
		end
	end
	local papers = 0
	for _, row in ipairs(grid) do
		for _, cell in ipairs(row) do
			if cell.paper == true and cell.neighbors < 4 then
				papers = papers + 1
				if removeCellFromGrid then
					cell.paper = false
				end
			end
		end
	end
	if breakCondition(papers) then
		return papers
	else
		return papers + removePapers(removeCellFromGrid, breakCondition)
	end
end
print("papersOneRound: " .. removePapers(false, function() return true end))
print("papersUntilDone: " .. removePapers(true, function(count) return count == 0 end))
