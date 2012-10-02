root = File.expand_path('../../../../lib/simulkan', __FILE__)
require File.join(root, 'card')

module Simulkan
  class Getkanban < Scenario
    def init
    end

    def build_board opts = {}
      #        Name , Type                    columns_points: [Des, Dev,Test],Subs,    $  # Day_ready
      Card.new 's1' , Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 11, among:    0}  #  1 (test)
      Card.new 's2' , Card::CLASS_NORMAL    , columns_points: [  0,   0,  12], attributes: {subs: 12, among:    0}  #  1 (test)
      Card.new 's3' , Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 11, among:    0}  #  1 (test)
      Card.new 's4' , Card::CLASS_NORMAL    , columns_points: [  0,   0,  11], attributes: {subs: 10, among:    0}  #  2 (dev done)
      Card.new 's5' , Card::CLASS_NORMAL    , columns_points: [  0,   0,  13], attributes: {subs: 13, among:    0}  #  2 (dev done)
      Card.new 's6' , Card::CLASS_NORMAL    , columns_points: [  0,   8,  12], attributes: {subs: 11, among:    0}  #  3 (dev doing)
      Card.new 's7' , Card::CLASS_NORMAL    , columns_points: [  0,  13,  14], attributes: {subs: 12, among:    0}  #  3 (dev doing)
      Card.new 's8' , Card::CLASS_NORMAL    , columns_points: [  0,   9,  14], attributes: {subs: 10, among:    0}  #  3 (Design done)
      Card.new 's9' , Card::CLASS_NORMAL    , columns_points: [  6,  13,  15], attributes: {subs: 12, among:    0}  #  4 (Design doing)
      Card.new 's10', Card::CLASS_NORMAL    , columns_points: [ 10,  10,  12], attributes: {subs: 11, among:    0}  #  4 (Design doing)
      Card.new 's11', Card::CLASS_NORMAL    , columns_points: [ 12,  11,  15], attributes: {subs: 13, among:    0}  #  5 (Ready)
      Card.new 's12', Card::CLASS_NORMAL    , columns_points: [  7,  10,  13], attributes: {subs: 10, among:    0}  #  6 (Ready)
      Card.new 's13', Card::CLASS_NORMAL    , columns_points: [  8,  11,  12], attributes: {subs: 10, among:    0}  #  6 (Ready)
      Card.new 's14', Card::CLASS_NORMAL    , columns_points: [  7,  11,  11], attributes: {subs: 10, among:    0}  #  7 (Ready)
      Card.new 's15', Card::CLASS_NORMAL    , columns_points: [  5,   9,   8], attributes: {subs:  7, among:    0}  #  8 (Ready)
      Card.new 's16', Card::CLASS_NORMAL    , columns_points: [  5,   7,   6], attributes: {subs:  6, among:    0}  #
      Card.new 's17', Card::CLASS_NORMAL    , columns_points: [  6,   8,   7], attributes: {subs:  7, among:    0}  #
      Card.new 's18', Card::CLASS_NORMAL    , columns_points: [  4,   9,   8], attributes: {subs:  7, among:    0}  #
      Card.new 's19', Card::CLASS_NORMAL    , columns_points: [  9,   9,   8], attributes: {subs: 10, among:    0}  #
      Card.new 's20', Card::CLASS_NORMAL    , columns_points: [  8,  10,   7], attributes: {subs:  8, among:    0}  #
      Card.new 's21', Card::CLASS_NORMAL    , columns_points: [  7,  10,   7], attributes: {subs:  7, among:    0}  #
      Card.new 's22', Card::CLASS_NORMAL    , columns_points: [  9,  11,   8], attributes: {subs:  9, among:    0}  #
      Card.new 's23', Card::CLASS_NORMAL    , columns_points: [  7,  10,   9], attributes: {subs: 11, among:    0}  #
      Card.new 's24', Card::CLASS_NORMAL    , columns_points: [  8,  10,   9], attributes: {subs:  9, among:    0}  #
      Card.new 's25', Card::CLASS_NORMAL    , columns_points: [ 10,   8,  11], attributes: {subs:  8, among:    0}  #
      Card.new 's26', Card::CLASS_NORMAL    , columns_points: [  8,  11,  13], attributes: {subs: 11, among:    0}  #
      Card.new 's27', Card::CLASS_NORMAL    , columns_points: [ 10,  11,  12], attributes: {subs: 10, among:    0}  #
      Card.new 's28', Card::CLASS_NORMAL    , columns_points: [  9,   9,   9], attributes: {subs:  9, among:    0}  #
      Card.new 's29', Card::CLASS_NORMAL    , columns_points: [ 11,  10,  11], attributes: {subs: 11, among:    0}  #
      Card.new 's30', Card::CLASS_NORMAL    , columns_points: [  9,   8,   7], attributes: {subs:  7, among:    0}  #
      Card.new 'e1' , Card::CLASS_EXPEDITE  , columns_points: [ 14,  15,  16], attributes: {subs:  0, among: 5000}  #  dead_time 21 - incoming day 18
      Card.new 'f1' , Card::CLASS_FIXDATE   , columns_points: [  3,   5,   7], attributes: {subs:  0, among: 2200}  #  deliver at 15
      Card.new 'f2' , Card::CLASS_FIXDATE   , columns_points: [  4,   9,   8], attributes: {subs: 25, among:    0}  #  deliver at 20
      Card.new 'i1' , Card::CLASS_INTANGIBLE, columns_points: [  0,   5,  11], attributes: {subs:  0, among:    0}  #   3 (Dev doing)
      Card.new 'i2' , Card::CLASS_INTANGIBLE, columns_points: [  1,  13,   6], attributes: {subs:  0, among:    0}  #   8 (Ready)
      Card.new 'i3' , Card::CLASS_INTANGIBLE, columns_points: [  1,   6,   1], attributes: {subs:  0, among:    0}  #
    end
  end
end
