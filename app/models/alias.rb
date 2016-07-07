class Alias < ActiveRecord::Base
  has_many :monikers
  has_many :avengers, through: :monikers
end
