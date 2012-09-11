class Board

  $board_id = 0

  attr_accessor :name

  def initialize name = false
    $board_id  += 1
    @id         = $board_id
    @name       = name ? name : 'unnamed' + $board_id.to_s
    @last_uid   = -1
    @columns    = {}
    @current    = 0
  end

  def size
    @columns.count
  end

  def empty?
    @columns.count == 0
  end

  def add column
    @columns[next_uid]  = column
    order
  end

  alias :<< :add

  def exists? column
    find_uid column
  end

  def delete column_to_delete
    uid = find_uid column_to_delete
    @columns.delete uid if uid
    order
    uid
  end

  def each &blk
    return unless block_given?
    @columns.keys.each{|uid| yield @columns[uid] }
  end

  def each_uid &blk
    return unless block_given?
    @columns.keys.each{|uid| yield uid, @columns[uid] }
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

  def column
    @columns[@columns.keys[@current]]
	end

	def cycle
		last
puts 'last column'
		begin
puts "  column #{column.id} have #{column.size} cards"
			work_points = column.work_points
puts "  work_points #{work_points}"
			card = column.first
			while (work_points > 0) && (column.next?) do
puts "  card #{column.card.id}"
				if column.card
					work_points = column.card.consume_column_points column.id, work_points
					column.next
				else
					if previous
					  card = false
						column.first
						if column.card.get_column_points column.id == 0
							card = column.card
							column.delete card
						end
						next
						column.add card if card
					end
				end
			end
			card = column.card
		end while previous
	end

  private
  def uid
    @last_uid
  end

  def next_uid
    @last_uid += 1
  end

  def find_uid column_to_find
    each_uid do |uid, column|
      return uid if column_to_find.equal? column
    end
    false
  end

  def order
  	pos = 0
		@columns.keys.each do |uid|
			@columns[uid].order= pos
			pos += 1
		end
  end
end
