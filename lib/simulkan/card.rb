class Card

  CLASS_NORMAL      = 1
  CLASS_FIXDATE     = 2
  CLASS_INTANGIBLE  = 3
  CLASS_EXPEDITE    = 4

	STORY_POINTS = 5

  $card_id = 0

  attr_reader :id, :counted
  attr_accessor :name, :body, :columns_points, :blocked, :blocked_at_column, :blocked_when_points, :service_class

  def initialize name = false, opts = {}
    $card_id             += 1
    @id                   = $card_id
    @name                 = name || $card_id.to_s
    @body                 = opts[:body] || ''
    @attributes           = opts[:attributes] || {}
    set_column_points(opts[:columns_points] || 0)
    @blocked_at_column    = opts[:blocked_at_column] || -1
    @blocked_when_points  = opts[:blocked_when_points] || -1
    @service_class        = opts[:service_class] || CLASS_NORMAL
  end

  def attribute_get name
    @attributes[name]
  end

  def attribute_set opts = {}
    opts.each{|k,v| @attributes[k] = v}
  end

  def set_column_points columns_points
    @columns_points	= Array.new
    @counted = Array.new
    if columns_points.is_a? Array
    	columns_points.each do |points|
    		@columns_points << points
    	end
    else
      columns_points.times do |i|
      	@columns_points << STORY_POINTS
      end
  	end
    @counted = [false] * @columns_points.size
    @added   = [false] * @columns_points.size
  end

  def added column, iteration
    @added[column] = iteration
  end

  def history
    @added
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
  	# return positive -> completed/blocked and more points
  	# return 0 -> completed/blocked and no more points
  	# return negative -> no completed/blocked and no more points
  	return(points) unless @columns_points.count > column
    return(points) if done?(column)
    return(points) if blocked?
  	result = points - @columns_points[column]
  	if result < 0
  		@columns_points[column] -= points
    else
      @columns_points[column] = 0
  	end

  	if (blocked_at_column < 0) || (blocked_at_column == column)
  	  if @columns_points[column] <= @blocked_when_points
  	    @blocked = true

  	    exceed = @blocked_when_points - @columns_points[column]
  	    @columns_points[column] = @blocked_when_points

        return exceed if result < 0
  	    return result + exceed
  	  end
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

	def blocked?
	  @blocked == true
	end

end
