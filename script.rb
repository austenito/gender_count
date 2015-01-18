#!/usr/bin/env ruby

require 'gendered'
require 'csv'

file = ARGV[0]
unless file
  raise 'You need to specfiy a csv file'
end

names = []
CSV.read(file)[1..-1].each do |row|
  ticket_first_name = row[0]
  if ticket_first_name && ticket_first_name.length > 0
    names << ticket_first_name
  end
end

name_list = Gendered::NameList.new(names)
name_list.guess!

stats = Hash.new(0)
not_guessed = []
name_list.each do |name|
  puts "#{name.value} - #{name.gender}"
  if name.gender == :male
    stats[:male] = stats[:male] + 1
  elsif name.gender == :female
    stats[:female] = stats[:female] + 1
  else
    stats[:not_guessed] = stats[:not_guessed] + 1
    not_guessed << name
  end
end

puts "==========="

puts not_guessed
stats[:total] = stats[:male] + stats[:female] + stats[:not_guessed]
puts stats

