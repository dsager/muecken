require 'json'
class Muecken::Entry
  attr_accessor :date, :description, :value, :currency

  def self.from_hash(data)
    entry = new
    entry.date = data[:date] if data[:date]
    entry.description = data[:description] if data[:description]
    entry.value = data[:value] if data[:value]
    entry.currency = data[:currency] if data[:currency]
    entry
  end

  def date=(date_value)
    @date = date_value.class <= Date ? date_value : Date.parse(date_value)
  end

  def to_s
    "[#{date}] #{currency} #{value} - #{description}"
  end

  def to_hash
    {
      date: date,
      description: description,
      value: value,
      currency: currency,
    }
  end

  def to_json
    to_hash.to_json
  end
end
