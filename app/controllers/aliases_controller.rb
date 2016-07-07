class AliasesController < ApplicationController

  def show
    @alias = Alias.find(params[:id])
    @avengers = @alias.avengers
  end

end
