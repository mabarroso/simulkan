root = File.expand_path('../../lib', __FILE__)
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


end
