root = File.expand_path('../../../../lib/simulkan', __FILE__)
require File.join(root, 'card')

module Simulkan
  class Getkanban < Scenario
    def init
      #        Name , Type                    [Des, Dev,Test],Subs,    $   # Day_ready
      add_card('s1' , Card::CLASS_NORMAL    , [  0,   0,  11],  11,    0 ) #  1 (test)
      add_card('s2' , Card::CLASS_NORMAL    , [  0,   0,  12],  12,    0 ) #  1 (test)
      add_card('s3' , Card::CLASS_NORMAL    , [  0,   0,  11],  11,    0 ) #  1 (test)
      add_card('s4' , Card::CLASS_NORMAL    , [  0,   0,  11],  10,    0 ) #  2 (dev done)
      add_card('s5' , Card::CLASS_NORMAL    , [  0,   0,  13],  13,    0 ) #  2 (dev done)
      add_card('s6' , Card::CLASS_NORMAL    , [  0,   8,  12],  11,    0 ) #  3 (dev doing)
      add_card('s7' , Card::CLASS_NORMAL    , [  0,  13,  14],  12,    0 ) #  3 (dev doing)
      add_card('s8' , Card::CLASS_NORMAL    , [  0,   9,  14],  10,    0 ) #  3 (Design done)
      add_card('s9' , Card::CLASS_NORMAL    , [  6,  13,  15],  12,    0 ) #  4 (Design doing)
      add_card('s10', Card::CLASS_NORMAL    , [ 10,  10,  12],  11,    0 ) #  4 (Design doing)
      add_card('s11', Card::CLASS_NORMAL    , [ 12,  11,  15],  13,    0 ) #  5 (Ready)
      add_card('s12', Card::CLASS_NORMAL    , [  7,  10,  13],  10,    0 ) #  6 (Ready)
      add_card('s13', Card::CLASS_NORMAL    , [  8,  11,  12],  10,    0 ) #  6 (Ready)
      add_card('s14', Card::CLASS_NORMAL    , [  7,  11,  11],  10,    0 ) #  7 (Ready)
      add_card('s15', Card::CLASS_NORMAL    , [  5,   9,   8],   7,    0 ) #  8 (Ready)
      add_card('s16', Card::CLASS_NORMAL    , [  5,   7,   6],   6,    0 ) #
      add_card('s17', Card::CLASS_NORMAL    , [  6,   8,   7],   7,    0 ) #
      add_card('s18', Card::CLASS_NORMAL    , [  4,   9,   8],   7,    0 ) #
      add_card('s19', Card::CLASS_NORMAL    , [  9,   9,   8],  10,    0 ) #
      add_card('s20', Card::CLASS_NORMAL    , [  8,  10,   7],   8,    0 ) #
      add_card('s21', Card::CLASS_NORMAL    , [  7,  10,   7],   7,    0 ) #
      add_card('s22', Card::CLASS_NORMAL    , [  9,  11,   8],   9,    0 ) #
      add_card('s23', Card::CLASS_NORMAL    , [  7,  10,   9],  11,    0 ) #
      add_card('s24', Card::CLASS_NORMAL    , [  8,  10,   9],   9,    0 ) #
      add_card('s25', Card::CLASS_NORMAL    , [ 10,   8,  11],   8,    0 ) #
      add_card('s26', Card::CLASS_NORMAL    , [  8,  11,  13],  11,    0 ) #
      add_card('s27', Card::CLASS_NORMAL    , [ 10,  11,  12],  10,    0 ) #
      add_card('s28', Card::CLASS_NORMAL    , [  9,   9,   9],   9,    0 ) #
      add_card('s29', Card::CLASS_NORMAL    , [ 11,  10,  11],  11,    0 ) #
      add_card('s30', Card::CLASS_NORMAL    , [  9,   8,   7],   7,    0 ) #
      add_card('e1' , Card::CLASS_EXPEDITE  , [ 14,  15,  16],   0, 5000 ) #  dead_time 21 - incoming day 18
      add_card('f1' , Card::CLASS_FIXDATE   , [  3,   5,   7],   0, 2200 ) #  deliver at 15
      add_card('f2' , Card::CLASS_FIXDATE   , [  4,   9,   8],  25,    0 ) #  deliver at 20
      add_card('i1' , Card::CLASS_INTANGIBLE, [  0,   5,  11],   0,    0 ) #   3 (Dev doing)
      add_card('i2' , Card::CLASS_INTANGIBLE, [  1,  13,   6],   0,    0 ) #   8 (Ready)
      add_card('i3' , Card::CLASS_INTANGIBLE, [  1,   6,   1],   0,    0 ) #
    end
  end
end
