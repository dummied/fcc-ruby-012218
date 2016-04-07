require 'csv'

data = CSV.foreach('avengers.csv', headers: true)

overall_count = data.count

puts "The Avengers have had #{overall_count} members."

women_count = data.count{|row| row['Gender'] == 'FEMALE'}

women_percentage = women_count.to_f/overall_count * 100

men_count = data.count { |row| row['Gender'] == 'MALE' }

men_percentage = men_count.to_f/overall_count * 100

puts "The Avengers are #{women_percentage}% women and #{men_percentage}% men."

dead_count = data.count { |row| row['Death1'] == 'YES' }

dead_percentage = dead_count.to_f/overall_count * 100

puts "You have a #{dead_percentage}% chance of dying."

dead_women_count = data.count do |row|
   row['Gender'] == 'FEMALE' && row['Death1'] == 'YES' 
end

dead_women_percentage = dead_women_count.to_f/women_count * 100

puts "A woman has a #{dead_women_percentage}% chance of dying."

dead_men_count = data.count do |row|
   row['Gender'] == 'MALE' && row['Death1'] == 'YES' 
end

dead_men_percentage = dead_men_count.to_f/men_count * 100

puts "A man has a #{dead_men_percentage}% chance of dying."

if dead_men_percentage > dead_women_percentage
    puts "Men are #{(dead_men_percentage - dead_women_percentage)/dead_men_percentage * 100}% more likely to die."
elsif dead_women_percentage > dead_men_percentage
    puts "Women die more frequently."
else
    puts "Weird. Equal chances."
end

twice_dead = data.count {|row| row['Death2'] == 'YES' }
thrice_dead = data.count {|row| row['Death3'] == 'YES' }
fourth_dead = data.count {|row| row['Death4'] == 'YES'}
fifth_dead = data.count{|row| row['Death5'] == 'YES'}

total_death_toll = dead_count + twice_dead + thrice_dead + fourth_dead + fifth_dead

puts "Overall, Avengers have died #{total_death_toll} times (so far)."

first_date = data.first['Year'].to_i

current_date = Time.now.year.to_i

time_interval = current_date - first_date

yearly_deaths = total_death_toll.to_f/time_interval

puts "An average of #{yearly_deaths} Avengers die each year."