json.extract! item, :id, :title, :description, :date, :rating, :created_at, :updated_at
json.url item_url(item, format: :json)
