class Column

  $column_id = 0

	attr_reader :id
  attr_accessor :name, :order, :wip, :resources_hight, :resources_low, :resource_points, :uncertainty, :last_work_points

  def initialize name = false, opts = {}
    $column_id        += 1
    @id                = $column_id
    @name              = name ? name : 'unnamed' + $column_id.to_s
    @order             = opts[:order] || @id
    @last_uid          = -1
    @cards             = {}
    @current           = 0
    @wip               = opts[:wip] || 0
    @resources_hight   = opts[:resources_hight] || 1
    @resources_low     = opts[:resources_low] || 0
    @resource_points   = opts[:resource_points] || 2
    @uncertainty   	   = opts[:uncertainty] || false
    @last_work_points  = 0
  end

  def size
    @cards.count
  end

  def empty?
    @cards.count == 0
  end

  def wip?
  	return false if @wip == 0
    size > @wip - 1
  end

  def add card
    raise WipException if wip?
    @cards[next_uid]  = card
  end

  alias :<< :add

  def exists? card
    find_uid card
  end

  def delete card_to_delete
    uid = find_uid card_to_delete
    @cards.delete uid if uid
    uid
  end

  def each &blk
    return unless block_given?
    @cards.keys.each{|uid| yield @cards[uid] }
  end

  def each_uid &blk
    return unless block_given?
    @cards.keys.each{|uid| yield uid, @cards[uid] }
  end

  def first
    @current = 0
  end

  def last
    @current = size - 1
  end

  def next
    @current += 1
    if @current > size - 1
      @current = size - 1
      return false
    end
    return true
  end

  def next?
  	@current < size - 1
	end

  def previous
    @current -= 1
    if @current < 0
      @current = 0
      return false
    end
    return true
  end

  def previous?
  	@current > 0
	end

  def go position
    @current = position if position < size
  end

  def current
    @current
	end

  def card
    return false if @cards.empty?
    @cards[@cards.keys[@current]]
	end

	def resources= resources
	  if resources.is_a? Array
  	  @resources_hight = resources[0]
  	  @resources_low	 = resources[1]
  	else
  	  @resources_hight = resources
  	  @resources_low	 = 0
    end
	end

	def resources
	  @resources_hight + @resources_low / 2.0
  end

  def work_points
  	points = 0
  	@resources_hight.times do
  		points += Resource.work max: @resource_points, random: @uncertainty
  	end
  	@resources_low.times do
  		points += Resource.work max: @resource_points, random: @uncertainty, lower: true
  	end
  	@last_work_points = points
  end

  def done order = @order
  	r = 0
  	@cards.keys.each do |uid|
      r += 1 if @cards[uid].done?(order)
  	end
  	r
	end

  def atwork order = @order
  	r = 0
  	@cards.keys.each do |uid|
      r += 1 if @cards[uid].atwork?(order)
  	end
  	r
	end

  def blocked order = @order
  	r = 0
  	@cards.keys.each do |uid|
      r += 1 if @cards[uid].blocked?
  	end
  	r
	end

  private
  def uid
    @last_uid
  end

  def next_uid
    @last_uid += 1
  end

  def find_uid card_to_find
    each_uid do |uid, card|
      return uid if card_to_find.equal? card
    end
    false
  end

end
