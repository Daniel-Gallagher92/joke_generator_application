class ChatgptService 
include HTTParty

  def initialize 
    @api_key = Rails.application.credentials.chat_api_key
  end

  def generate_joke 
    prompt = "Tell me a dad joke"
    max_tokens = 30

    api_endpoint = "https://api.openai.com/v1/engines/davinci-codex/completions"
    headers = {
      "Authorization" => "Bearer #{@api_key}",
      "Content-Type" => "application/json"
    }

    payload = {
      prompt: prompt,
      max_tokens: max_tokens
    }.to_json

    response = HTTParty.post(api_endpoint, headers: headers, body: payload)
    JSON.parse(response.body)["choices"][0]["text"].strip
  end
end