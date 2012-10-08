root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/factory')
require 'singleton'

class Game
  include Singleton

  attr_reader :scenario

  def initialize
    @scenario = Simulkan.use :default
  end

  def use scenario
    @scenario = Simulkan.use scenario
  end

end
