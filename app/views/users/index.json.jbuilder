json.array!(@users) do |user|
  json.extract! user, :email, :title, :first_name, :middle_name, :last_name, :phone, :office, :office_hours, :photo_url, :description, :admin
  json.url user_url(user, format: :json)
end
