module Simulkan
  class Getkanban < Scenario
  end
end
# Name Type Des Dev Test Subs Day_ready
#  s1                11   11   1 (test)
#  s2                12   12   1 (test)
#  s3                11   11   1 (test)
#  s4                11   10   2 (dev done)
#  s5                13   13   2 (dev done)
#  s6            8   12   11   3 (dev doing)
#  s7            13  14   12   3 (dev doing)
#  s8            9   14   10   3 (Design done)
#  s9        6   13  15   12   4 (Design doing)
#  s10       10  10  12   11   4 (Design doing)
#  s11       12  11  15   13   5 (Ready)
#  s12       7   10  13   10   6 (Ready)
#  s13       8   11  12   10   6 (Ready)
#  s14       7   11  11   10   7 (Ready)
#  s15       5   9   8    7    8 (Ready)
#  s16       5   7   6    6
#  s17       6   8   7    7
#  s18       4   9   8    7
#  s19       9   9   8    10
#  s20       8   10  7    8
#  s21       7   10  7    7
#  s22       9   11  8    9
#  s23       7   10  9    11
#  s24       8   10  9    9
#  s25       10  8   11   8
#  s26       8   11  13   11
#  s27       10  11  12   10
#  s28       9   9   9    9
#  s29       11  10  11   11
#  s30       9   8   7    7
#  e1        14  15  16   $5000 dead_time 21 - incoming day 18
#  f1        3   5   7    $2200 deliver at 15
#  f2        4   9   8    25    deliver at 20
#  i1            5   11   -     3 (Dev doing)
#  i2        1   13  6    -     8 (Ready)
#  i3        1   6   1    -