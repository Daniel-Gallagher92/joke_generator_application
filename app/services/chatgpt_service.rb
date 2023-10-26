class ChatgptService 
include HTTParty

  def initialize 
    @api_key = Rails.application.credentials.chat_api_key
  end

  def generate_joke 
    prompt = "Short dad joke with a setup and punchline. Make sure it's less than 100 tokens. Go!"
      max_tokens = 100
      temperature = 0.7
      
      api_endpoint = "https://api.openai.com/v1/engines/davinci/completions"
      headers = {
        "Authorization" => "Bearer #{@api_key}",
        "Content-Type" => "application/json"
      }
      
      payload = {
        prompt: prompt,
        max_tokens: max_tokens,
        temperature: temperature
      }.to_json
      
      begin
        response = HTTParty.post(api_endpoint, headers: headers, body: payload, timeout: 80)
        joke = JSON.parse(response.body)["choices"][0]["text"].strip
        clean_joke(joke)
      rescue Net::ReadTimeout => e
        Rails.logger.error("Timeout Error: #{e.message}")
        return "Joke's on you! We couldn't fetch a joke right now. Please try again later."
      end
  end

  private 

  # def clean_joke(joke)
  #   joke.gsub(/(\r\n|\r|\n)/, "<br>").html_safe
  # end

  def clean_joke(joke) 
    sentences = joke.split(".").uniq
    sentences.join('. ').strip + '.'
  end
end