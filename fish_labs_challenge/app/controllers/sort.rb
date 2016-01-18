FishLabsChallenge::App.controllers :sort do
  get :name do
    user_id = params[:user_id]
    order = params[:order].to_s

    if user_id.present? && order.present?
      if order == 'desc' || order == 'asc'
        user = User.where(id: user_id).first
        if user
          monsters = user.owned_monsters.map { |monster|
            monster_data = Monster.where(id: monster).first

          }
          monsters = monsters.sort_by { |monster| monster[:name] }

          if order == 'desc'
            monsters = monsters.reverse
          end

          monsters_json = monsters.map { |monster|
            inner_json = {
              id: monster.id,
              name: monster.name,
              power: monster.power,
              type: monster.monstertype,
              weakness: monster.monsterweakness
            }.deep_stringify_keys
          }.to_json
        else
          return { message: 'User does not exist' }.to_json
        end
      else
        return { message: 'Invalid order' }.to_json
      end
    else
      return { message: 'Missing params' }.to_json
    end
  end

  get :power do
    user_id = params[:user_id]
    order = params[:order].to_s

    if user_id.present? && order.present?
      if order == 'desc' || order == 'asc'
        user = User.where(id: user_id).first
        if user
          monsters = user.owned_monsters.map { |monster|
            monster_data = Monster.where(id: monster).first

          }
          monsters = monsters.sort_by { |monster| monster[:power] }

          if order == 'desc'
            monsters = monsters.reverse
          end

          monsters_json = monsters.map { |monster|
            inner_json = {
              id: monster.id,
              name: monster.name,
              power: monster.power,
              type: monster.monstertype,
              weakness: monster.monsterweakness
            }.deep_stringify_keys
          }.to_json
        else
          return { message: 'User does not exist' }.to_json
        end
      else
        return { message: 'Invalid order' }.to_json
      end
    else
      return { message: 'Missing params' }.to_json
    end
  end

  get :type do
    user_id = params[:user_id]
    order = params[:order].to_s

    if user_id.present? && order.present?
      if order == 'desc' || order == 'asc'
        user = User.where(id: user_id).first
        if user
          monsters = user.owned_monsters.map { |monster|
            monster_data = Monster.where(id: monster).first

          }
          monsters = monsters.sort_by { |monster| monster[:type] }

          if order == 'desc'
            monsters = monsters.reverse
          end

          monsters_json = monsters.map { |monster|
            inner_json = {
              id: monster.id,
              name: monster.name,
              power: monster.power,
              type: monster.monstertype,
              weakness: monster.monsterweakness
            }.deep_stringify_keys
          }.to_json
        else
          return { message: 'User does not exist' }.to_json
        end
      else
        return { message: 'Invalid order' }.to_json
      end
    else
      return { message: 'Missing params' }.to_json
    end
  end

  get :weakness do
    user_id = params[:user_id]
    order = params[:order].to_s

    if user_id.present? && order.present?
      if order == 'desc' || order == 'asc'
        user = User.where(id: user_id).first
        if user
          monsters = user.owned_monsters.map { |monster|
            monster_data = Monster.where(id: monster).first

          }
          monsters = monsters.sort_by { |monster| monster[:monsterweakness] }

          if order == 'asc'
            monsters = monsters.reverse
          end

          monsters_json = monsters.map { |monster|
            inner_json = {
              id: monster.id,
              name: monster.name,
              power: monster.power,
              type: monster.monstertype,
              weakness: monster.monsterweakness
            }.deep_stringify_keys
          }.to_json
        else
          return { message: 'User does not exist' }.to_json
        end
      else
        return { message: 'Invalid order' }.to_json
      end
    else
      return { message: 'Missing params' }.to_json
    end
  end

end
