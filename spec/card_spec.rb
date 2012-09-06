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

end
