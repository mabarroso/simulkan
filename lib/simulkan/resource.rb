class Resource

  def self.work opts = {}
    lower     = opts[:lower] || false
    random    = opts[:random] || false
    max       = opts[:max] || 2
    min       = opts[:min] || 1

    if random
      amount = [*min..max].sample
    else
      amount = max
    end

    amount = amount / 2.0 if lower

    return amount
  end

end
