FactoryBot.define do
  factory :devise_user, class: 'User' do
    id {1}
    email {"test@user.com"}
    password {"qwerty"}
    # Add additional fields as required via your User model
  end
end