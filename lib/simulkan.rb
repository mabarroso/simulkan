require 'indicator'
require 'googlecharts'

root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'graph')
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')
require File.join(root, 'exceptions/wip_exception')

UNCERTAINTY = false
RESOURCE_POINTS = 6

backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3, resources_hight: 2, resource_points: RESOURCE_POINTS, uncertainty: UNCERTAINTY})
board << Column.new('Development', {wip: 5, resources_hight: 3, resource_points: RESOURCE_POINTS, uncertainty: UNCERTAINTY})
board << Column.new('QA', {wip: 3, resources_hight: 2, resource_points: RESOURCE_POINTS, uncertainty: UNCERTAINTY})
board << historylog

CYCLES = 30

log = ''
graph_data = Array.new
cards_n = 0
Indicator::spin :pre => "Work", :frames => ['   ', '.  ', '.. ', '...'], :count => CYCLES do |spin|
  CYCLES.times do |i|
  	board.first
  	bcklog_n = board.column.size
  	board.next
  	first_need = board.column.wip - board.column.atwork
  	if bcklog_n < first_need
			(first_need - bcklog_n).times do
				cards_n += 1
			  card = Card.new cards_n.to_s, columns_points: [0, 8, 12, 4, 0]
			  backlog << card
			end
		end

  	graph_data << board.acumulative
    log += sprintf("%2d %s %s\n", i, board.snapshot, graph_data[i])
    spin.post= " in progress #{i} of #{CYCLES} cycles #{board.snapshot}"
    spin.inc
    board.cycle
    #sleep 0.5
  end
end

puts log
puts Graph::acumulative graph_data, board
puts
puts Graph::acumulative graph_data
puts

puts Graph::sla board
