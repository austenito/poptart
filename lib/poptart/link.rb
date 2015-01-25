class Link
  attr_reader :rel, :href, :method

  def initialize(href:, rel:, method:)
    @rel = rel
    @href = href
    @method = method
  end
end
