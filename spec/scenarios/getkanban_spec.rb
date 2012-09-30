root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/getkanban')

describe Simulkan::Getkanban do
  it "should be correct class" do
    s = Simulkan.use :getkanban
    s.name.should ==  Simulkan::Getkanban
  end
end
