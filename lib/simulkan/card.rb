class Card

	STORY_POINTS = 5

  $card_id = 0

  attr_reader :id, :counted
  attr_accessor :name, :body, :columns_points

  def initialize name = false, opts = {}
    $card_id       += 1
    @id             = $card_id
    @name           = name || $card_id.to_s
    @body           = opts[:body] || ''
    set_column_points(opts[:columns_points] || 0)
  end

  def set_column_points columns_points
    @columns_points	= Array.new
    @counted = Array.new
    if columns_points.is_a? Array
    	columns_points.each do |points|
    		@columns_points << points
    		@counted << false
    	end
    else
      columns_points.times do |i|
      	@columns_points << STORY_POINTS
      	@counted << false
      end
  	end
  end

  def get_column_points column
  	@columns_points[column]
  end

	def atwork? column
		@columns_points[column] > 0
	end

	def done? column
		!atwork?(column)
	end

  def consume_column_points column, points
  	# return positive -> completed and more points
  	# return 0 -> completed and no more points
  	# return negative -> no completed and no more points
  	return(points) unless @columns_points.count > column
    return(points) if done?(column)
  	result = points - @columns_points[column]
  	if result < 0
  		@columns_points[column] -= points
    else
      @columns_points[column] = 0
  	end
  	result
  end

	def acumulative column
		r = []
		(column+1).times do |i|
			j = column - i
		  r[j] = 1
		  @counted[j] = true
		end
		r
	end

	def acumulative_newest column
		r = []
		(column+1).times do |i|
			j = column - i
			if @counted[j]
				r[j] = 0
			else
			  r[j] = 1
			  @counted[j] = true
			end
		end
		r
	end

end
