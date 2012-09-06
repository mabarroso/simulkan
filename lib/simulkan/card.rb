class Card

	STORY_POINTS = 5

  $card_id = 0

  attr_reader :id
  attr_accessor :name, :body, :columns_points

  def initialize name = false, opts = {}
    $card_id       += 1
    @id             = $card_id
    @name           = name || $card_id.to_s
    @body           = opts[:body] || ''
    set_column_points opts[:columns_points] || 0
  end

  def set_column_points columns_points
    @columns_points	= []
    if columns_points.is_a? Array
    	columns_points.each do |points|
    		@columns_points << points
    	end
    else
      columns_points.times do |i|
      	@columns_points << STORY_POINTS
      end
  	end
  end

  def get_column_points column
  	@columns_points[column]
  end

	#
  def consume_column_points column, points
  	# return positive -> completed and more points
  	# return 0 -> completed and no more points
  	# return negative -> o completed and no more points
  	points - @columns_points[column]
  end

end
