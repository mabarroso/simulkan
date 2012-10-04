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

  	graph_data << acumulative(board)
    log += sprintf("%2d %s %s\n", i, snapshot(board), graph_data[i])
    spin.post= " in progress #{i} of #{CYCLES} cycles #{snapshot(board)}"
    spin.inc
    board.cycle
    #sleep 0.5
  end
end

puts log
puts Graph::graph_acumulative graph_data, board
puts
puts Graph::graph_acumulative graph_data
puts

puts graph_sla board
