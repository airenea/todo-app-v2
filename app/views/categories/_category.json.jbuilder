json.extract! category, :id, :title, :body, :user, :emoji, :created_at, :updated_at
json.url category_url(category, format: :json)
