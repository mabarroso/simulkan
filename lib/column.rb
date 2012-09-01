class Column

  $column_id = 0

  attr_accessor :name, :wip

  def initialize name = false, wip = 9999
    $column_id   += 1
    @id         = $column_id
    @name       = name ? name : 'unnamed' + $column_id.to_s
    @last_uid   = -1
    @cards      = {}
    @current    = 0
    @wip        = wip
  end

  def size
    @cards.count
  end

  def empty?
    @cards.count == 0
  end

  def add card
    raise WipException if size > wip - 1
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
    @cards[@cards.keys[@current]]
	end

  private
  def uid
    @last_uid
  end

  def next_uid
    @last_uid += 1
  end

  def find_uid card_to_find
    each do |uid, card|
      return uid if card_to_find.equal? card
    end
    false
  end

end
