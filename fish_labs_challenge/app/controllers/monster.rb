FishLabsChallenge::App.controllers :monster do

  get :list do
    monsters = Monster.all
    monsters_json = monsters.map { |monster|
      inner_json = {
        id: monster.id,
        name: monster.name,
        power: monster.power,
        type: monster.monstertype,
        weakness: monster.monsterweakness
      }.deep_stringify_keys
    }.to_json
  end

  post :create, :csrf_protection => false do
    json = JSON.parse(request.body.read)

    name = json['name'].to_s
    power = json['power'].to_i
    type = json['type'].to_s

    unless name.present?
      return { message: 'Monster needs a name'}.to_json
    end

    if power >= 101 || power <= 0
      return { message: 'Power too high or too low - must be between 0 and 100' }.to_json
    end

    if TypeChecker.convert_to_index(type).nil?
      return { message: 'Invalid type' }.to_json
    end

    weakness = TypeChecker.get_weakness(type)
    new_monster = Monster.create(name: name, power: power, monstertype: type, monsterweakness: weakness)
    if new_monster.id
      { message: 'Monster created succesfully', id: new_monster.id }.to_json
    else
      { message: 'Monster with this name exists already - names must be unique' }.to_json
    end
  end

end
