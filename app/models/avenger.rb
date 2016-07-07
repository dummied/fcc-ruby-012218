class Avenger < ActiveRecord::Base
  has_many :monikers
  has_many :aliases, through: :monikers

  paginates_per 24

  def alias_list
    aliases.map(&:name)
  end

  def alias_list=(comma_separated_aliases)
    these_aliases = comma_separated_aliases.split(",").map(&:strip)
    aliases.destroy_all
    these_aliases.each do |a|
      aliases << Alias.find_or_initialize_by(name: a)
    end
  end
end
