root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resoure')
require File.join(root, 'column')
require File.join(root, 'board')


backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'
board = Board.new

board << Column.new 'Design', 3, 3
board << Column.new 'Development', 3, 3
board << Column.new 'QA', 3, 3

