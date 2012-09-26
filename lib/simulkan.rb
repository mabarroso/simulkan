require 'indicator'
require 'googlecharts'

root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')
require File.join(root, 'exceptions/wip_exception')

UNCERTAINTY = false
RESOURCE_POINTS = 6

def snapshot board
	r = ''
	blockeds = 0
	board.first
	board.each do |column|
		blockeds += column.blocked
		r += sprintf("%2d/%2d[%1d-%2d-%2d] |",  column.atwork, column.done, column.wip, column.resources, column.last_work_points)
	end
	r += sprintf("%1d|",  blockeds)
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

def graph_sla board
	axis_x_days = {}
	last_column = board.size - 1
	board.first
	board.each do |column|
		column.each do |card|
			if card.history[last_column]
				days = card.history[last_column] - card.history[1]
				axis_x_days[days] = 0 if axis_x_days[days] == nil
				axis_x_days[days] += 1
			end
#		  puts "->##{card.id} Class: #{card.service_class} #{card.history}\n"
		end
	end
	axis_x_days.keys.max.times do |i|
		axis_x_days[i] = 0 if axis_x_days[i] == nil
	end
	sorted_array = axis_x_days.sort
	axis_x_days = Hash[sorted_array.map {|k,v| [k,v]}]
	total_work = axis_x_days.values.inject{|sum,x| sum + x }
  axis_x_days_percent = Hash[axis_x_days.map {|k,v| [k, (v==0)?'':"#{100*v/total_work}%"]}]
  axis_x_days_sla = Hash[axis_x_days.map {|k,v| sum = axis_x_days.keys.inject{|sum,i| (i>k)?sum:sum + axis_x_days[i] }; [k, "#{100*sum/total_work}%"]}]

#  puts axis_x_days.keys.to_s
#  puts axis_x_days_sla.values.to_s
#  puts axis_x_days.values.to_s
#  puts '---'

	Gchart.bar( data: axis_x_days.values,
							axis_with_labels: ['x', 'x', 'x', 'x', 'y'],
           		axis_labels: [axis_x_days.keys, axis_x_days_sla.values, axis_x_days.values, axis_x_days_percent.values, 1.step(axis_x_days.values.max,1).to_a],
           		size: '600x300'
           	)
end

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
graph = Array.new
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
puts
puts graph_sla board

# Name Type Des Dev Test Subs Day_ready
#  s1                11   11   1 (test)
#  s2                12   12   1 (test)
#  s3                11   11   1 (test)
#  s4                11   10   2 (dev done)
#  s5                13   13   2 (dev done)
#  s6            8   12   11   3 (dev doing)
#  s7            13  14   12   3 (dev doing)
#  s8            9   14   10   3 (Design done)
#  s9        6   13  15   12   4 (Design doing)
#  s10       10  10  12   11   4 (Design doing)
#  s11       12  11  15   13   5 (Ready)
#  s12       7   10  13   10   6 (Ready)
#  s13       8   11  12   10   6 (Ready)
#  s14       7   11  11   10   7 (Ready)
#  s15       5   9   8    7    8 (Ready)
#  s16       5   7   6    6
#  s17       6   8   7    7
#  s18       4   9   8    7
#  s19       9   9   8    10
#  s20       8   10  7    8
#  s21       7   10  7    7
#  s22       9   11  8    9
#  s23       7   10  9    11
#  s24       8   10  9    9
#  s25       10  8   11   8
#  s26       8   11  13   11
#  s27       10  11  12   10
#  s28       9   9   9    9
#  s29       11  10  11   11
#  s30       9   8   7    7
#  e1        14  15  16   $5000 dead_time 21 - incoming day 18
#  f1        3   5   7    $2200 deliver at 15
#  f2        4   9   8    25    deliver at 20
#  i1            5   11   -     3 (Dev doing)
#  i2        1   13  6    -     8 (Ready)
#  i3        1   6   1    -
