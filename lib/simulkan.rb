root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')


backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3, resources_hight:3})
board << Column.new('Design_done', {done: true})
board << Column.new('Development', {wip: 3, resources_hight:3})
board << Column.new('Development_done', {done: true})
board << Column.new('QA', {wip: 3, resources_hight:3})
board << Column.new('QA_done', {done: true})
board << historylog

20.times do |i|
  card = Card.new (i+1).to_s, columns_points: [0, 5, 10, 2, 0]
  backlog << card
end
