class Muecken::Parser::Entry
  FIELDS = [:date, :value, :description, :currency]
  attr_accessor *FIELDS

  def self.from_hash(data)
    entry = new
    FIELDS.each do |field|
      entry.send("#{field}=", data[field]) if data[field]
    end
    entry
  end

  def to_s
    "[#{date}] #{currency} #{value} - #{description}"
  end
end
