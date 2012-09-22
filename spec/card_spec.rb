root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')

describe Card do
  it "default names should be different" do
  	c1 = Card.new
  	c2 = Card.new
  	c1.name.should_not == c2.name
  end

  it "default name should be id" do
  	c1 = Card.new
  	c1.name.should == c1.id.to_s
  end

  it "all column point must be equal" do
  	c = Card.new
  	c.set_column_points 2
  	c.get_column_points(0).should == c.get_column_points(1)
  end

  it "all column point must be different" do
  	c = Card.new
  	c.set_column_points [1,2]
  	c.get_column_points(0).should_not == c.get_column_points(1)
  end

  it "consume_column_points must be 0" do
  	c = Card.new
  	c.set_column_points [5]
  	c.consume_column_points(0, 5).should == 0
  end

  it "consume_column_points must be positive" do
  	c = Card.new
  	c.set_column_points [5]
  	c.consume_column_points(0, 6).should > 0
  end

  it "consume_column_points must be negative" do
  	c = Card.new
  	c.set_column_points [5]
  	c.consume_column_points(0, 4).should < 0
  end

  it "must be atwork" do
  	c = Card.new
  	c.set_column_points [5]
  	c.atwork?(0).should be_true
  	c.done?(0).should be_false
  end

  it "must be done" do
  	c = Card.new
  	c.set_column_points [0]
  	c.atwork?(0).should be_false
  	c.done?(0).should be_true
  end

	it "must be count first" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(0).should == [1]
	end

	it "must be count two" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(1).should == [1, 1]
	end

	it "must be count all" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(2).should == [1, 1, 1]
	end

	it "must be counted first" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(0)
		c.acumulative_newest(0).should == [0]
	end

	it "must be counted one but not others" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(0)
		c.acumulative_newest(2).should == [0, 1, 1]
	end

	it "must be counted two but not last" do
		c = Card.new
		c.set_column_points 3
		c.acumulative_newest(1)
		c.acumulative_newest(2).should == [0, 0, 1]
	end

	it "must be count first" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(0).should == [1]
	end

	it "must be count two" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(1).should == [1, 1]
	end

	it "must be count all" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(2).should == [1, 1, 1]
	end

	it "must be counted first" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(0)
		c.acumulative(0).should == [1]
	end

	it "must be counted one but not others" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(0)
		c.acumulative(2).should == [1, 1, 1]
	end

	it "must be counted two but not last" do
		c = Card.new
		c.set_column_points 3
		c.acumulative(1)
		c.acumulative(2).should == [1, 1, 1]
	end

	it "must be blocked or not" do
		c = Card.new
		c.blocked = true
		c.blocked?.should be_true
		c.blocked = false
		c.blocked?.should be_false
	end

	it "must not consume points when blocked" do
		c = Card.new 'test', columns_points: [5]
		c.blocked = true
		c.consume_column_points(0, 5).should == 5
	end

	it "must be block at column 0 when points are greater than block limit" do
		c = Card.new 'test', blocked_at_column: 0, blocked_when_points: 2, columns_points: [5]
    c.blocked?.should be_false
		c.consume_column_points(0, 5).should == 2
		c.blocked?.should be_true
  end

	it "must be block at column 0 when points are equal than block limit" do
		c = Card.new 'test', blocked_at_column: 0, blocked_when_points: 2, columns_points: [5]
		c.blocked?.should be_false
		c.consume_column_points(0, 3).should == 0
		c.blocked?.should be_true
  end

	it "must be block at column 0 when points decrease to block limit" do
		c = Card.new 'test', blocked_at_column: 0, blocked_when_points: 2, columns_points: [5]
		c.blocked?.should be_false
		c.consume_column_points(0, 2).should == -3
		c.blocked?.should be_false
		c.consume_column_points(0, 1).should == 0
		c.blocked?.should be_true
		c.consume_column_points(0, 1).should == 1
		c.consume_column_points(0, 2).should == 2
  end

	it "must be block at column 1 when points" do
		c = Card.new 'test', blocked_at_column: 1, blocked_when_points: 2, columns_points: [5, 5]
		c.consume_column_points(0, 5).should == 0
		c.blocked?.should be_false
		c.consume_column_points(1, 5).should == 2
    c.blocked?.should be_true
  end

	it "must be block for al columns when points" do
		c = Card.new 'test', blocked_when_points: 2, columns_points: [5, 5, 5]
		c.consume_column_points(0, 5).should == 2
		c.blocked?.should be_true
		c.blocked = false
		c.consume_column_points(1, 5).should == 2
		c.blocked?.should be_true
		c.blocked = false
		c.consume_column_points(2, 5).should == 2
		c.blocked?.should be_true
  end

	it "must be added to 0 at iteration 1" do
		c = Card.new
		c.set_column_points 3
		c.added 0, 1
		c.history.should == [1, false, false]
	end

	it "must be added to 1 at iteration 2" do
		c = Card.new
		c.set_column_points 3
		c.added 1, 2
		c.history.should == [false, 2, false]
	end

	it "must be added to all at iterations 1, 2, 3" do
		c = Card.new
		c.set_column_points 3
		c.added 0, 1
		c.added 1, 2
		c.added 2, 3
		c.history.should == [1, 2, 3]
	end

	it "must be normal service class" do
		c = Card.new
		c.service_class.should == Card::CLASS_NORMAL
	end

	it "must be normal service class" do
		c = Card.new 'test', service_class: Card::CLASS_NORMAL
		c.service_class.should == Card::CLASS_NORMAL
	end

	it "must be fixdate service class" do
		c = Card.new 'test', service_class: Card::CLASS_FIXDATE
		c.service_class.should == Card::CLASS_FIXDATE
	end

	it "must be intangible service class" do
		c = Card.new 'test', service_class: Card::CLASS_INTANGIBLE
		c.service_class.should == Card::CLASS_INTANGIBLE
	end

	it "must be expedite service class" do
		c = Card.new 'test', service_class: Card::CLASS_EXPEDITE
		c.service_class.should == Card::CLASS_EXPEDITE
	end

end
