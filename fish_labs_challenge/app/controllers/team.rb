FishLabsChallenge::App.controllers :team do
  post :add, :csrf_protection => false do
    json = JSON.parse(request.body.read)

    username = json['username']
    password = json['password']
    monster_id = json['monster_id']

    user = User.where(email: username, password: password).first
    monster = Monster.find_by_id(monster_id)

    if user && monster
      if user.team_one.length == 3
        if user.team_two.length == 3
          if user.team_three.length == 3
            if user.owned_monsters.length == 20
              return { message: 'You own too many monsters' }.to_json
            else
              user.owned_monsters << monster_id
              user.save
              return { message: 'Added this monster to owned monsters' }.to_json
            end
          else
            if user.team_three
              if TeamChecker.valid?(user.team_three, monster_id.to_i)
                user.team_three << monster_id
                user.owned_monsters << monster_id
              else
                return { message: 'This monster is in a team' }.to_json
              end
            else
              user.team_three = [monster_id]
              user.owned_monsters << monster_id
            end
            user.save
            return { message: 'Added to team 3' }.to_json
          end
        else
          if user.team_two
            if TeamChecker.valid?(user.team_two, monster_id.to_i)
              user.team_two << monster_id
              user.owned_monsters << monster_id
            else
              return { message: 'This monster is in a team' }.to_json
            end
          else
            user.team_two = [monster_id]
            user.owned_monsters << monster_id
          end
          user.save

          return { message: 'Added to team 2' }.to_json
        end
      else
        if user.team_one
          if TeamChecker.valid?(user.team_one, monster_id.to_i)
            user.team_one << monster_id
            user.owned_monsters << monster_id
          else
            return { message: 'This monster is in a team' }.to_json
          end
        else
          user.team_one = [monster_id]
          user.owned_monsters << monster_id
        end
        user.save

        return { message: 'Added to team 1' }.to_json
      end
    else
      return { message: 'That user or monster does not exist' }.to_json
    end
  end

  post :delete_from_team, :csrf_protection => false do
    json = JSON.parse(request.body.read)

    username = json['username']
    password = json['password']
    monster_id = json['monster_id'].to_i

    user = User.where(email: username, password: password).first
    monster = Monster.find_by_id(monster_id)

    if user && monster
      user.team_one.delete(monster_id)
      user.team_two.delete(monster_id)
      user.team_three.delete(monster_id)
      user.save

      return { message: 'Deleted monster from a team' }.to_json
    else
      return { message: 'That user or monster does not exist' }.to_json
    end
  end

  post :delete, :csrf_protection => false do
    json = JSON.parse(request.body.read)

    username = json['username']
    password = json['password']
    monster_id = json['monster_id'].to_i

    user = User.where(email: username, password: password).first
    monster = Monster.find_by_id(monster_id)

    if user && monster
      user.team_one.delete(monster_id)
      user.team_two.delete(monster_id)
      user.team_three.delete(monster_id)
      user.owned_monsters.delete(monster_id)
      user.save
      return { message: 'Deleted monster' }.to_json
    else
      return { message: 'That user or monster does not exist' }.to_json
    end
  end

end
