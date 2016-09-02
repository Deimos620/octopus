json.array!(@project_restrictions) do |project_restriction|
  json.extract! project_restriction, :id
  json.url project_restriction_url(project_restriction, format: :json)
end
