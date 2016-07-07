require 'csv'

data = CSV.foreach("#{Rails.root}/vendor/assets/data/avengers.csv", headers: true, converters: [:integer, :date], header_converters: :symbol)

def died_times(avenge)
  avenge.count { |column, value| column.to_s.starts_with?("death") && value == "YES" }
end

def return_times(avenge)
  avenge.count { |column, value| column.to_s.starts_with?("return") && value == "YES" }
end

def alive(avenge)
  died_times(avenge) - return_times(avenge) == 0
end

data.each do |avenge|
  puts avenge.inspect
  Avenger.create!(
    name: avenge[:namealias],
    appearances: avenge[:appearances],
    current: avenge[:current] == "YES",
    gender: avenge[:gender].downcase,
    year: avenge[:year],
    honorary: avenge[:honorary] == "FULL",
    notes: avenge[:notes],
    died_times: died_times(avenge),
    return_times: return_times(avenge),
    alive: alive(avenge),
    wiki_url: avenge[:url]
  ) unless Avenger.where(name: avenge[:name_alias]).any?
end


