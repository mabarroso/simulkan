root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'column')
require File.join(root, 'board')

describe Board do
  BOARD_LAST = 6

  def filled
    board = Board.new
    BOARD_LAST.times do |i|
      column = Column.new (i+1).to_s
      board << column
    end
    board
  end

  it "should be empty" do
  	d = Board.new
  	d.empty?.should be_true
  end

  it "default names should be different" do
  	d1 = Board.new
  	d2 = Board.new
  	d1.name.should_not == d2.name
  end

  it "should add" do
    d = Board.new
    size = d.size
    column = Column.new
    d << column
		d.size.should == size + 1
  end

  it "should be first equal 1" do
  	d = filled
		d.first
		d.column.name.should == '1'
  end

  it "should be last equal {BOARD_LAST}" do
  	d = filled
		d.last
		d.column.name.should == BOARD_LAST.to_s
  end

  it "should be last-1 equal {BOARD_LAST-1}" do
  	d = filled
		d.last
		d.previous
		d.column.name.should == (BOARD_LAST-1).to_s
  end

  it "should be go to first position equal first" do
  	d = filled
  	d.first
  	position = d.current
  	d.last
  	d.go position
  	d.current.should == position
  end

  it "should be go to last position equal last" do
  	d = filled
  	d.last
  	position = d.current
  	d.first
  	d.go position
  	d.current.should == position
  end

  it "should be false when next from last" do
  	d = filled
  	d.last
  	d.next.should be_false
  end

  it "should be false when previous from last" do
  	d = filled
  	d.first
  	d.previous.should be_false
  end

  it "should be last when next from last" do
  	d = filled
  	d.last
  	d.next
    d.current.should == d.last
  end

  it "should be first when previous from first" do
  	d = filled
  	d.first
  	d.previous
    d.current.should == d.first
  end

  it "should be no next from last" do
  	d = filled
		d.last
		d.next?.should be_false
  end

  it "should be no previous from first" do
  	d = filled
		d.first
		d.previous?.should be_false
  end

  it "should be next from first" do
  	d = filled
		d.first
		d.next?.should be_true
  end

  it "should be previous from last" do
  	d = filled
		d.last
		d.previous?.should be_true
  end

  it "should be next from previous of last" do
  	d = filled
		d.last
		d.previous
		d.next?.should be_true
  end

  it "should be previous from next of first" do
  	d = filled
		d.first
		d.next
		d.previous?.should be_true
  end

  it "should not exists" do
  	d = filled
    column = Column.new (BOARD_LAST+1).to_s
		d.exists?(column).should be_false
  end

  it "should exists" do
  	d = filled
    column = Column.new (BOARD_LAST+1).to_s
    d << column
		d.exists?(column).should be_true
  end


  it "should not delete inexistent column" do
  	d = filled
    column = Column.new (BOARD_LAST+1).to_s
    size = d.size
		d.delete column
		d.size.should == size
  end

  it "should delete column" do
  	d = filled
    column = Column.new (BOARD_LAST+1).to_s
    d << column
    size = d.size
		d.delete column
		d.size.should == size - 1
  end

  it "should ordered" do
  	d = filled
  	order = 0
  	d.each do |column|
  		column.order.should == order
  		order +=1
  	end
  end

  it "should reordered" do
  	d = filled
  	d.first
  	d.next
  	d.delete d.column
  	order = 0
  	d.each do |column|
  		column.order.should == order
  		order +=1
  	end
  end

  it "should pull a card from column1 to column2" do
#  	d = filled
    d = Board.new
    d << Column.new
    d << Column.new

  	d.first
		d.column << Card.new('dummy', columns_points: [0, 0])

		d.first
		d.column.size.should == 1
		d.next
		d.column.size.should == 0


		d.cycle
		d.first
		d.column.size.should == 0
		d.next
		d.column.size.should == 1
  end

end
