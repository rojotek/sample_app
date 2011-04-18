Factory.define :user do |user|
  user.name                  "Rob Dawson"
  user.email                 "robert@rojotek.com"
  user.password              "Password1!"  
  user.password_confirmation "Password1!"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end