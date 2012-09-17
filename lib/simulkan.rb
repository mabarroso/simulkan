require 'indicator'
require 'googlecharts'

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

def graph_acumulative graph, board
  legend = []
  labels = []
	data = []
	i = -1
	j = -1
	graph.each do |row|
		i+= 1
		j = -1
		labels << i
		board.first
		row.each do |col|
			legend << board.column.name if i==0
			board.next
			j+=1
			data[j] = [] if i==0
			data[j][i] = col
		end
	end

	Gchart.line(title: "Acumulative",
							title_size: 20,
							title_color: '444444',
							background: 'EEEEEE',
							chart_background: 'CCCCCC',
							data: data,
							line_colors: "AAAAAA,FF0000,00FF00,0000FF,888888",
							legend: legend,
							labels: labels,
							size: '600x300'
							)
end

backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3, resources_hight:2, resource_points:3, uncertainty: false})
board << Column.new('Development', {wip: 3, resources_hight:3, resource_points:3, uncertainty: false})
board << Column.new('QA', {wip: 3, resources_hight:1, resource_points:3, uncertainty: false})
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
puts graph_acumulative graph, board
