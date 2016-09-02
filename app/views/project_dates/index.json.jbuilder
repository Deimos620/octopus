json.array!(@project_dates) do |project_date|
  json.extract! project_date, :id
  json.url project_date_url(project_date, format: :json)
end
