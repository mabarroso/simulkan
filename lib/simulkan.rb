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
		#r += " #{column.atwork}/#{column.done}[#{column.wip}-#{column.resources}-#{column.last_work_points}] |"
		r += sprintf("%2d/%2d[%1d-%2d-%2d] |",  column.atwork, column.done, column.wip, column.resources, column.last_work_points)
	end
	r
end

backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3, resources_hight:3})
board << Column.new('Development', {wip: 3, resources_hight:3})
board << Column.new('QA', {wip: 3, resources_hight:3})
board << historylog

20.times do |i|
  card = Card.new (i+1).to_s, columns_points: [0, 10, 20, 10, 0]
  backlog << card
end
CYCLES = 30

log = ''
Indicator::spin :pre => "Work", :frames => ['   ', '.  ', '.. ', '...'], :count => CYCLES do |spin|
  CYCLES.times do |i|
    log += sprintf("%2d %s\n", i, snapshot(board))
    spin.post= " in progress #{i} of #{CYCLES} cycles #{snapshot(board)}"
    spin.inc
    board.cycle
    #sleep 0.5
  end
end

puts log

