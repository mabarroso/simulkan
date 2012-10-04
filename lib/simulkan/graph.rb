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
end
