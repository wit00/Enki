json.array!(@cards) do |card|
  json.extract! card, :id, :question, :answer, :score, :user_id
  json.url card_url(card, format: :json)
end
