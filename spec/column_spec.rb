root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'column')
require File.join(root, 'exceptions/wip_exception')

describe Column do
  COLUMN_LAST = 6

  def filled
    column = Column.new
    COLUMN_LAST.times do |i|
      card = Card.new (i+1).to_s
      column << card
    end
    column
  end

  it "should be empty" do
  	d = Column.new
  	d.empty?.should be_true
  end

  it "default names should be different" do
  	d1 = Column.new
  	d2 = Column.new
  	d1.name.should_not == d2.name
  end

  it "should add" do
    d = Column.new
    size = d.size
    card = Card.new
    d << card
		d.size.should == size + 1
  end

  it "should be first equal 1" do
  	d = filled
		d.first
		d.card.name.should == '1'
  end

  it "should be last equal {COLUMN_LAST}" do
  	d = filled
		d.last
		d.card.name.should == COLUMN_LAST.to_s
  end

  it "should be last-1 equal {COLUMN_LAST-1}" do
  	d = filled
		d.last
		d.previous
		d.card.name.should == (COLUMN_LAST-1).to_s
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
    card = Card.new (COLUMN_LAST+1).to_s
		d.exists?(card).should be_false
  end

  it "should exists" do
  	d = filled
    card = Card.new (COLUMN_LAST+1).to_s
    d << card
		d.exists?(card).should be_true
  end


  it "should not delete inexistent card" do
  	d = filled
    card = Card.new (COLUMN_LAST+1).to_s
    size = d.size
		d.delete card
		d.size.should == size
  end

  it "should delete card" do
  	d = filled
    card = Card.new (COLUMN_LAST+1).to_s
    d << card
    size = d.size
		d.delete card
		d.size.should == size - 1
  end

  it "should add card when 1 to WIP limit" do
  	column = filled
  	column.wip= column.size + 1

    column.wip?.should be_false
    card = Card.new (COLUMN_LAST+1).to_s
    column << card
    column.wip?.should be_true
  end

  it "should raise exception when WIP exceed" do
  	column = filled
  	column.wip= column.size

    column.wip?.should be_true
    card = Card.new (COLUMN_LAST+1).to_s
  	lambda { column << card }.should raise_error
  end

  it "should be 1" do
  	column = Column.new
  	column.resources= 1
  	column.resources.should == 1
  end

  it "should be 1.5" do
  	column = Column.new
  	column.resources= 1, 1
  	column.resources.should == 1.5
  end

  it "should be resource_points" do
  	column = Column.new
  	column.resources= 1, 0
		column.resource_points = 2
		column.uncertainty = false
  	column.work_points.should == 2
  end

  it "should be resource_points / 2" do
  	column = Column.new
  	column.resources= 0, 1
		column.resource_points = 2
		column.uncertainty = false
  	column.work_points.should == 2 / 2.0
  end

  it "should be resource_points + resource_points / 2" do
  	column = Column.new
  	column.resources= 1, 1
		column.resource_points = 2
		column.uncertainty = false
  	column.work_points.should == 2 + 2 / 2.0
  end

  it "should be any diferent when uncertainty" do
    diferent = false
  	column = Column.new
  	column.resources= 1, 1
		column.resource_points = 2
		column.uncertainty = true
    aw = column.work_points
    10.times do
  	  w = column.work_points
  	  diferent = true unless aw == w
  	end
  	diferent.should be_true
  end

  it "must be all atwork" do
    column = Column.new
    column.order = 0
    card = Card.new
    card.set_column_points [5]
    column << card

    column.atwork.should == 1
    column.done.should == 0
  end

  it "must be all done" do
    column = Column.new
    column.order = 0
    card = Card.new
    card.set_column_points [0]
    column << card

    column.atwork.should == 0
    column.done.should == 1
  end

end
