class Graph

  def self.graph_acumulative card_data, board = false
    legend = []
    labels = []
  	data = []
  	i = -1
  	j = -1
  	card_data.each do |row|
  		i+= 1
  		j = -1
  		labels << i
  		board.first if board
  		row.each do |col|
        if board
  			  legend << board.column.name if i==0
  			  board.next
  			end
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

  def self.graph_sla board
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

end
