User.find_or_create_by!(email: 'admin@yorrany.com.br') do |user|
  user.password = 'password123'
  user.password_confirmation = 'password123'
end

