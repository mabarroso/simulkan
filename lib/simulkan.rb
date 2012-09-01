root = File.expand_path('../../lib', __FILE__)
require File.join(root, 'card')
require File.join(root, 'column')
require File.join(root, 'board')


backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'
board = Board.new

column = Column.new 'Design'
column = Column.new 'Development'
column = Column.new 'QA'

