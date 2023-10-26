class JokesController < ApplicationController 
  def index 
    jokes = Rails.cache.fetch("joke", expires_in: 20.minutes) do 
      service = ChatgptService.new
      Array.new(10) { service.generate_joke }
    end
    @joke = jokes.sample
  end
end