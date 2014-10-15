require 'csv'

class Muecken::Parser::CSV
  def self.read_file(file)
    entries = []
    CSV.foreach(file) do |row|
      entries << create_entry(row)
    end
    entries
  end

  def self.create_entry(row)
    row = row.map(&:strip)
    Muecken::Parser::Entry.from_hash({
      date: Date.parse(row[0]),
      description: row[1],
      value: row[2].to_f,
      currency: row[3],
    })
  end
end
