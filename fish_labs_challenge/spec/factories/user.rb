FactoryGirl.define do
  factory :user do
    email "test_email"
    password "test_pw"
    team_one []
    team_two []
    team_three []
    owned_monsters []
  end
end
