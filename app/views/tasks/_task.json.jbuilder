json.extract! task, :id, :title, :body, :completion, :user, :category_id, :date, :created_at, :updated_at
json.url task_url(task, format: :json)
