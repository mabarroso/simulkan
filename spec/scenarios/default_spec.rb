root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/default')

describe Simulkan::Default do
  it "should be correct class" do
    s = Simulkan.use :default
    s.name.should ==  Simulkan::Default
  end
end
