class Moniker < ActiveRecord::Base
  belongs_to :alias
  belongs_to :avenger
end
