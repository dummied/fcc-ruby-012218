module AvengersHelper

  def aliases_links(avenger)
    if avenger.aliases.any?
      avenger.aliases.map{|a| link_to a.name, a}.to_sentence
    else
      "None"
    end
  end

end
