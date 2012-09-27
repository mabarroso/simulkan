root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/factory')

describe Simulkan::Factory do
  it "should be correct size" do
    s = Simulkan.use :dummy
    s.name.should ==  Simulkan::Dummy
  end
end
