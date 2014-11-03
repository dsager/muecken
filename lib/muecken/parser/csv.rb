# encoding: utf-8
require 'csv'

module Muecken
  module Parser
    class CSV
      def self.read_file(file)
        entries = []
        ::CSV.foreach(file, encoding: 'UTF-8') do |row|
          unless row.compact.empty?
            entries << create_entry(row)
          end
        end
        entries
      end

      def self.create_entry(row)
        row = row.map { |field| field.to_s.strip }
        Muecken::Entry.from_hash({
          date: Date.parse(row[0]),
          description: row[1],
          value: row[2].to_f,
          currency: row[3],
        })
      end
    end
  end
end
