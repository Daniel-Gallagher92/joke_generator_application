class JokesController < ApplicationController 
  def index 
    service = ChatgptService.new
    @joke = service.generate_joke
  end
end