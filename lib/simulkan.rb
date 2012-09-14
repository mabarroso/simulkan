require "indicator"

root = File.expand_path('../../lib/simulkan', __FILE__)
require File.join(root, 'card')
require File.join(root, 'resource')
require File.join(root, 'column')
require File.join(root, 'board')
require File.join(root, 'exceptions/wip_exception')

backlog = Column.new 'Backlog'
historylog = Column.new 'Historylog'

board = Board.new
board << backlog
board << Column.new('Design', {wip: 3000, resources_hight:3})
board << Column.new('Development', {wip: 3000, resources_hight:3})
board << Column.new('QA', {wip: 3000, resources_hight:3})
board << historylog

20.times do |i|
  card = Card.new (i+1).to_s, columns_points: [0, 5, 10, 2, 0]
  backlog << card
end

CYCLES = 10

Indicator::spin :pre => "Work", :frames => ['   ', '.  ', '.. ', '...'], :count => CYCLES do |spin|
  CYCLES.times do |i|
    spin.inc
    spin.post= " in progress #{i} of #{CYCLES} cycles"
    board.cycle
    sleep 0.2
  end
end