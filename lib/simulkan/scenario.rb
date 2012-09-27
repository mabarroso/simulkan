root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/factory')

module Simulkan
  class Scenario < Simulkan::Factory
    class << self
      private :create
    end

    attr_reader :name, :version, :extrainfo

    def initialize(*args)
      @name       = self.class
      @version    = 0
      @extrainfo  = ''
      init
    end

    def init
    end

    def build_board opts = {}
    end

    def pre_cycle opts = {}
    end

    def post_cycle opts = {}
    end
  end

  def self.use name
    Factory.create eval name.to_s.capitalize
  end
end