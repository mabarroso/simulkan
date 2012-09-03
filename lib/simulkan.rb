root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'column')
require File.join(root, 'board')


backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'
board = Board.new

column = Column.new 'Design', 3
column = Column.new 'Development', 3
column = Column.new 'QA', 3

