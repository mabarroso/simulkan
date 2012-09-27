root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/dummy')

describe Simulkan::Dummy do
  it "should be correct class" do
    s = Simulkan.use :dummy
    s.name.should ==  Simulkan::Dummy
  end
end
