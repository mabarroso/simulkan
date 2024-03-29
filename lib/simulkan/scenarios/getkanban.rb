root = File.expand_path('../../../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')
require File.join(root, 'exceptions/wip_exception')

module Simulkan
  class Getkanban < Scenario

    attr_reader :cards, :ready, :historylog, :board

    def init
      build_cards
    end

    def build_board opts = {}
      @ready = Column.new 'Ready'
      @historylog = Column.new 'Historylog'

      @board = Board.new
      @board << @ready
      @board << Column.new('Design', {wip: 3, resources_hight: 2*2, resource_points: 6, uncertainty: true})
      @board << Column.new('Development', {wip: 5, resources_hight: 2*3, resource_points: 6, uncertainty: true})
      @board << Column.new('Test', {wip: 3, resources_hight: 2*2, resource_points: 6, uncertainty: true})
      @board << @historylog
    end

    private
    def build_cards
      @cards = []
                #        Name , Type                                   columns_points: [Des, Dev,Test],                    Subs,         $               # Day_ready
      @cards << Card.new('s1' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 11, money:    0, column: 4} ) #  1 (test)
      @cards << Card.new('s2' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   0,  12], attributes: {subs: 12, money:    0, column: 4} ) #  1 (test)
      @cards << Card.new('s3' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 11, money:    0, column: 4} ) #  1 (test)
      @cards << Card.new('s4' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 10, money:    0, column: 3} ) #  2 (dev done)
      @cards << Card.new('s5' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   0,  13], attributes: {subs: 13, money:    0, column: 3} ) #  2 (dev done)
      @cards << Card.new('s6' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   8,  12], attributes: {subs: 11, money:    0, column: 3} ) #  3 (dev doing)
      @cards << Card.new('s7' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,  13,  14], attributes: {subs: 12, money:    0, column: 3} ) #  3 (dev doing)
      @cards << Card.new('s8' , service_class: Card::CLASS_NORMAL    , columns_points: [  0,   9,  14], attributes: {subs: 10, money:    0, column: 2} ) #  3 (Design done)
      @cards << Card.new('s9' , service_class: Card::CLASS_NORMAL    , columns_points: [  6,  13,  15], attributes: {subs: 12, money:    0, column: 2} ) #  4 (Design doing)
      @cards << Card.new('s10', service_class: Card::CLASS_NORMAL    , columns_points: [ 10,  10,  12], attributes: {subs: 11, money:    0, column: 2} ) #  4 (Design doing)
      @cards << Card.new('s11', service_class: Card::CLASS_NORMAL    , columns_points: [ 12,  11,  15], attributes: {subs: 13, money:    0, column: 1} ) #  5 (Ready)
      @cards << Card.new('s12', service_class: Card::CLASS_NORMAL    , columns_points: [  7,  10,  13], attributes: {subs: 10, money:    0, column: 1} ) #  6 (Ready)
      @cards << Card.new('s13', service_class: Card::CLASS_NORMAL    , columns_points: [  8,  11,  12], attributes: {subs: 10, money:    0, column: 1} ) #  6 (Ready)
      @cards << Card.new('s14', service_class: Card::CLASS_NORMAL    , columns_points: [  7,  11,  11], attributes: {subs: 10, money:    0, column: 1} ) #  7 (Ready)
      @cards << Card.new('s15', service_class: Card::CLASS_NORMAL    , columns_points: [  5,   9,   8], attributes: {subs:  7, money:    0, column: 1} ) #  8 (Ready)
      @cards << Card.new('s16', service_class: Card::CLASS_NORMAL    , columns_points: [  5,   7,   6], attributes: {subs:  6, money:    0           } ) #
      @cards << Card.new('s17', service_class: Card::CLASS_NORMAL    , columns_points: [  6,   8,   7], attributes: {subs:  7, money:    0           } ) #
      @cards << Card.new('s18', service_class: Card::CLASS_NORMAL    , columns_points: [  4,   9,   8], attributes: {subs:  7, money:    0           } ) #
      @cards << Card.new('s19', service_class: Card::CLASS_NORMAL    , columns_points: [  9,   9,   8], attributes: {subs: 10, money:    0           } ) #
      @cards << Card.new('s20', service_class: Card::CLASS_NORMAL    , columns_points: [  8,  10,   7], attributes: {subs:  8, money:    0           } ) #
      @cards << Card.new('s21', service_class: Card::CLASS_NORMAL    , columns_points: [  7,  10,   7], attributes: {subs:  7, money:    0           } ) #
      @cards << Card.new('s22', service_class: Card::CLASS_NORMAL    , columns_points: [  9,  11,   8], attributes: {subs:  9, money:    0           } ) #
      @cards << Card.new('s23', service_class: Card::CLASS_NORMAL    , columns_points: [  7,  10,   9], attributes: {subs: 11, money:    0           } ) #
      @cards << Card.new('s24', service_class: Card::CLASS_NORMAL    , columns_points: [  8,  10,   9], attributes: {subs:  9, money:    0           } ) #
      @cards << Card.new('s25', service_class: Card::CLASS_NORMAL    , columns_points: [ 10,   8,  11], attributes: {subs:  8, money:    0           } ) #
      @cards << Card.new('s26', service_class: Card::CLASS_NORMAL    , columns_points: [  8,  11,  13], attributes: {subs: 11, money:    0           } ) #
      @cards << Card.new('s27', service_class: Card::CLASS_NORMAL    , columns_points: [ 10,  11,  12], attributes: {subs: 10, money:    0           } ) #
      @cards << Card.new('s28', service_class: Card::CLASS_NORMAL    , columns_points: [  9,   9,   9], attributes: {subs:  9, money:    0           } ) #
      @cards << Card.new('s29', service_class: Card::CLASS_NORMAL    , columns_points: [ 11,  10,  11], attributes: {subs: 11, money:    0           } ) #
      @cards << Card.new('s30', service_class: Card::CLASS_NORMAL    , columns_points: [  9,   8,   7], attributes: {subs:  7, money:    0           } ) #
      @cards << Card.new('e1' , service_class: Card::CLASS_EXPEDITE  , columns_points: [ 14,  15,  16], attributes: {subs:  0, money: 5000           } ) #  dead_time 21 - incoming day 18
      @cards << Card.new('f1' , service_class: Card::CLASS_FIXDATE   , columns_points: [  3,   5,   7], attributes: {subs:  0, money: 2200           } ) #  deliver at 15
      @cards << Card.new('f2' , service_class: Card::CLASS_FIXDATE   , columns_points: [  4,   9,   8], attributes: {subs: 25, money:    0           } ) #  deliver at 20
      @cards << Card.new('i1' , service_class: Card::CLASS_INTANGIBLE, columns_points: [  0,   5,  11], attributes: {subs:  0, money:    0, column: 3} ) #   3 (Dev doing)
      @cards << Card.new('i2' , service_class: Card::CLASS_INTANGIBLE, columns_points: [  1,  13,   6], attributes: {subs:  0, money:    0, column: 1} ) #   8 (Ready)
      @cards << Card.new('i3' , service_class: Card::CLASS_INTANGIBLE, columns_points: [  1,   6,   1], attributes: {subs:  0, money:    0           } ) #
    end
  end
end