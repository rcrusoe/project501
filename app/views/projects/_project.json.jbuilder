json.extract! project, :id, :title, :description, :category, :deadline, :created_at, :updated_at
json.url project_url(project, format: :json)