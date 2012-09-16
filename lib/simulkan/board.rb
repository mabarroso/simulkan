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
		begin
			work_points = column.work_points
			column.first
			is_valid_card = column.card
			while (work_points > 0) do
				if is_valid_card
					work_points = column.card.consume_column_points column.order, work_points
					is_valid_card = column.next
				end
				unless is_valid_card
				  card = false
					if !column.wip? && previous
						column.first
						begin
						  if column.card && column.card.done?(column.order)
							  card = column.card
							  column.delete card
						  end
						end while (!card && column.next)
						self.next
						if card
							column.add card
							column.last
							is_valid_card = column.card
						end
					end
					work_points = 0 unless card
				end
			end
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
