root = File.expand_path('../../../lib/simulkan', __FILE__)
require File.join(root, 'scenarios/getkanban')

describe Simulkan::Getkanban do
  it "should be correct class" do
    s = Simulkan.use :getkanban
    s.name.should ==  Simulkan::Getkanban
  end

  it "should be correct number of cards" do
    s = Simulkan.use :getkanban
    s.cards.count.should ==  36
  end

  it "should be correct number of cards by service class" do
    s = Simulkan.use :getkanban
    c = {}
    s.cards.each do |card|
      c[card.service_class] = c[card.service_class] ? c[card.service_class] + 1 : 1
    end
    c.keys.count.should == 4
    c[Card::CLASS_NORMAL].should ==  30
    c[Card::CLASS_EXPEDITE].should ==  1
    c[Card::CLASS_FIXDATE].should ==  2
    c[Card::CLASS_INTANGIBLE].should ==  3
  end

  it "should be correct amount of subs and money" do
    s = Simulkan.use :getkanban
    subs = 0
    money = 0
    s.cards.each do |card|
      subs += card.attribute_get :subs
      money += card.attribute_get :amount
    end
    subs.should ==  318
    money.should ==  7200
  end

end
