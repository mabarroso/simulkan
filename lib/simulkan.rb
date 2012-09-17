require "indicator"

root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')
require File.join(root, 'exceptions/wip_exception')

def snapshot board
	r = ''
	board.first
	board.each do |column|
		r += sprintf("%2d/%2d[%1d-%2d-%2d] |",  column.atwork, column.done, column.wip, column.resources, column.last_work_points)
	end
	r
end

def acumulative board
	r = [0] * board.size
	board.first
	board.each do |column|
		column.each do |card|
			columns = card.acumulative(column.order)
			columns.size.times do |i|
				r[i] += columns[i]
			end
		end
	end
	r
end

backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3, resources_hight:1, resource_points:6, uncertainty: false})
board << Column.new('Development', {wip: 3, resources_hight:3, resource_points:6, uncertainty: false})
board << Column.new('QA', {wip: 3, resources_hight:2, resource_points:6, uncertainty: false})
board << historylog

20.times do |i|
  card = Card.new (i+1).to_s, columns_points: [0, 8, 12, 4, 0]
  backlog << card
end
CYCLES = 30

log = ''
graph = Array.new
Indicator::spin :pre => "Work", :frames => ['   ', '.  ', '.. ', '...'], :count => CYCLES do |spin|
  CYCLES.times do |i|
  	graph << acumulative(board)
    log += sprintf("%2d %s %s\n", i, snapshot(board), graph[i])
    spin.post= " in progress #{i} of #{CYCLES} cycles #{snapshot(board)}"
    spin.inc
    board.cycle
    #sleep 0.5
  end
end

puts log

