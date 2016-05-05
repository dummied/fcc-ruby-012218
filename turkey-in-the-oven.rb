require 'csv'

class Avenger
  LIFE_FIELDS = 5.times.collect{|num| "Death#{num + 1}"} + 5.times.collect{|num| "Return#{num+1}"}
  attr_accessor :name,
                :wiki_page,
                :number_of_deaths,
                :number_of_returns,
                :gender,
                :current,
                :first_intro,
                :full_intro,
                :appearances,
                :death_records,
                :notes,
                :years_since_joining

  def initialize(row)
    self.name = row['Name/Alias']
    self.wiki_page = row['URL']
    self.gender = row['Gender']
    self.current = row['Current?'] == "YES" ? true : false
    self.first_intro = Date.new(row['Probationary Introl'].to_i) if row['Probationary Introl']
    self.appearances = row['Appearances'].to_i
    self.full_intro = Date.new(row['Full/Reserve Avengers Intro'].to_i)
    self.notes = row['Notes']
    self.years_since_joining = row['Years since joining'].to_i + 1
    self.death_records = row.to_h.values_at(*LIFE_FIELDS)
  end

  def currently_deceased?
    death_records.reject{|f| f == "NO"}.compact.length.odd?
  end

  def died?
    death_records.first == "YES"
  end

  def self.parse(csv)
    @avengers ||= CSV.foreach('avengers.csv', :headers => true).collect do |row|
      self.new(row)
    end
  end

  def self.avengers
    @avengers || []
  end

  def self.report(csv)
    avengers = parse(csv)
    output(avengers)
  end

  def self.output(avengers)
    to_console(total_number)
    to_console(died_at_least_once)
    to_console(still_dead)
    to_console(chance_to_come_back)
    to_console(gender_breakdown)
    to_console(gender_bias)
    honor_roll
  end

  def self.total_number
    "There have been #{avengers.count} members of the Avengers all time"
  end

  def self.died_count(subjects=avengers)
    subjects.count{|a| a.died?}
  end

  def self.dead_count(subjects=avengers)
    subjects.count{|a| a.currently_deceased?}
  end

  def self.by_gender(gender)
    avengers.select{|a| a.gender.downcase == gender}
  end

  def self.died_at_least_once
    "In all, #{died_count} (#{percent(died_count)}%) members have died _at least_ once."
  end

  def self.still_dead
    "In all, #{dead_count} (#{percent(dead_count)}%) members have stayed dead."
  end

  def self.chance_to_come_back
    "So, if you die, you have a #{percent_difference(died_count, dead_count)}% chance of coming back."
  end

  def self.gender_breakdown
    "The Avengers are "
  end

  def self.gender_bias
    women_percent = percent(died_count(by_gender("female")), by_gender("female").count)
    men_percent = percent(died_count(by_gender("male")), by_gender("male").count)
    if women_percent > men_percent
      "If you're a female member of the Avengers, you are #{percent_difference(women_percent, men_percent)}% more likely to die."
    elsif men_percent > women_percent
      "If you're a male member of the Avengers, you are #{percent_difference(men_percent, women_percent)}% more likely to die."
    else
      "It makes no difference your gender when it comes to life or death as an Avengers member."
    end
  end

  def self.honor_roll
    puts "The following Avengers remain dead (for now, as of 2015, and as far as official Avengers records are concerned):"
    avengers.select{ |a| a.currently_deceased? }.each do |avenger|
      puts avenger.name
      sleep 1
      puts avenger.notes
      sleep 2
      puts "\n"
    end
  end

  def self.percent_difference(cohort_one, cohort_two)
    percent(cohort_one - cohort_two, cohort_one)
  end


  def self.to_console(string)
    puts string + "\n\n"
    sleep 0.5
  end

  def self.percent(number_to_compare, base=avengers.count)
    (number_to_compare.to_f / base * 100).round(1)
  end

end

Avenger.report('avengers.csv')
