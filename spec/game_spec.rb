root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'game')

describe Game do
  it "should be get instance" do
    g = Game.instance
  	g.class.should ==  Game
  end

end

