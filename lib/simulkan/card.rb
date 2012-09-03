class Card

  $card_id = 0

  attr_reader :id
  attr_accessor :name, :body

  def initialize name = false, body={}
    $card_id   += 1
    @id         = $card_id
    @name       = name || $card_id.to_s
    @body       = body
  end

end
