root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'game')

describe Game do
  it "should be get instance" do
    g = Game.instance
  	g.class.should ==  Game
  end

  it "should be default scenario" do
    g = Game.instance
  	g.scenario.name.should ==  Simulkan::Default
  end

  it "should be selected scenario" do
    g = Game.instance
    g.use :dummy
  	g.scenario.name.should ==  Simulkan::Dummy
  end

end

