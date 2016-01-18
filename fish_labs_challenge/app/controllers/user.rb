FishLabsChallenge::App.controllers :user do
  post :register, :csrf_protection => false do
    json = JSON.parse(request.body.read)

    username = json['username']
    password = json['password']

    if username.present? && password.present?
      new_user = User.create(email: username, password: password, team_one: [], team_two: [], team_three: [])
      if new_user.id
        { message: 'Succesfully added this user', id: new_user.id }.to_json
      else
        { message: 'This user already exists' }.to_json
      end
    else
      { message: 'Missing some arguments' }.to_json
    end
  end
end
