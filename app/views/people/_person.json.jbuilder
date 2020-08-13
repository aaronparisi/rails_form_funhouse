json.extract! person, :id, :name, :email, :birthday, :country, :rating, :created_at, :updated_at
json.url person_url(person, format: :json)
