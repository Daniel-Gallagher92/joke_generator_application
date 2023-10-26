class ChatgptService 
include HTTParty

  def initialize 
    @api_key = Rails.application.credentials.chat_api_key
  end

  def generate_joke 
    Rails.cache.fetch("joke", expires_in: 1.hour) do 

      prompt = "Tell me a short dad joke"
      max_tokens = 1600
      
      api_endpoint = "https://api.openai.com/v1/engines/davinci/completions"
      headers = {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      }
      
      payload = {
        prompt: prompt,
        max_tokens: max_tokens,
        temperature: 0.2
      }.to_json
      
      begin
        response = HTTParty.post(api_endpoint, headers: headers, body: payload, timeout: 80)
        parsed = JSON.parse(response.body)["choices"][0]["text"].strip
      rescue Net::ReadTimeout => e
        Rails.logger.error("Timeout Error: #{e.message}")
        return "Joke's on you! We couldn't fetch a joke right now. Please try again later."
      end
      
    end
  end
end