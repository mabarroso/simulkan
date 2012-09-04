root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'resource')

describe Resource do
  it "should be max" do
  	w = Resource.work max: 2
  	w.should == 2
  end

  it "should be max" do
  	w = Resource.work max: 2, lower: true
  	w.should == 2 / 2.0
  end

  it "should be any diferent" do
    diferent = false
    aw = Resource.work max: 200, min: 1, random: true
    10.times do
  	  w = Resource.work max: 200, min: 1, random: true
  	  diferent = true unless aw == w
  	end
  	diferent.should be_true
  end
end
