require 'spec_helper'

describe '/sort' do
  describe '#name' do
    context 'when there is invalid params' do
      it 'returns a missing param json' do
        get '/sort/name', {}

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Missing params')
      end
    end

    context 'when the user owns one monster' do
      before do
        FactoryGirl.create :monster
        FactoryGirl.create :user, email: "test_name_one", owned_monsters: [4]
      end

      it 'returns that monster correctly' do
        get '/sort/name?user_id=1&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(4)
        expect(json[0]['name']).to eq('test_monster_name')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')
      end
    end

    context 'when the user owns two monsters' do
      before do
        FactoryGirl.create :monster, name: 'a_test_monster'
        FactoryGirl.create :monster, name: 'z_test_monster'
        FactoryGirl.create :user, email: "test_name_two", owned_monsters: [5, 6]
      end
      it 'returns the monsters sorted properly' do
        get '/sort/name?user_id=2&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(6)
        expect(json[0]['name']).to eq('z_test_monster')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')

        expect(json[1]['id']).to eq(5)
        expect(json[1]['name']).to eq('a_test_monster')
        expect(json[1]['power']).to eq(50)
        expect(json[1]['type']).to eq('fire')
        expect(json[1]['weakness']).to eq('water')
      end
    end
  end

  describe '#power' do
    context 'when there is invalid params' do
      it 'returns a missing param json' do
        get '/sort/power', {}

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Missing params')
      end
    end

    context 'when the user owns one monster' do
      before do
        FactoryGirl.create :monster, power: 51
        FactoryGirl.create :user, email: "test_name_one", owned_monsters: [7]
      end

      it 'returns that monster correctly' do
        get '/sort/power?user_id=3&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(7)
        expect(json[0]['name']).to eq('test_monster_name')
        expect(json[0]['power']).to eq(51)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')
      end
    end

    context 'when the user owns two monsters' do
      before do
        FactoryGirl.create :monster, name: "weak_monster", power: 50
        FactoryGirl.create :monster, name: "powerful_monster", power: 51
        FactoryGirl.create :user, email: "test_name_two", owned_monsters: [8, 9]
      end
      it 'returns the monsters sorted properly' do
        get '/sort/power?user_id=4&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(9)
        expect(json[0]['name']).to eq('powerful_monster')
        expect(json[0]['power']).to eq(51)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')

        expect(json[1]['id']).to eq(8)
        expect(json[1]['name']).to eq('weak_monster')
        expect(json[1]['power']).to eq(50)
        expect(json[1]['type']).to eq('fire')
        expect(json[1]['weakness']).to eq('water')
      end
    end
  end

  describe '#type' do
    context 'when there is invalid params' do
      it 'returns a missing param json' do
        get '/sort/type', {}

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Missing params')
      end
    end

    context 'when the user owns one monster' do
      before do
        FactoryGirl.create :monster
        FactoryGirl.create :user, email: "test_name_one", owned_monsters: [10]
      end

      it 'returns that monster correctly' do
        get '/sort/type?user_id=5&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(10)
        expect(json[0]['name']).to eq('test_monster_name')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')
      end
    end

    context 'when the user owns two monsters' do
      before do
        FactoryGirl.create :monster, name: "weak_monster", monstertype: 'electric'
        FactoryGirl.create :monster, name: "powerful_monster", monstertype: 'fire'
        FactoryGirl.create :user, email: "test_name_two", owned_monsters: [11, 12]
      end
      it 'returns the monsters sorted properly' do
        get '/sort/type?user_id=6&order=asc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(11)
        expect(json[0]['name']).to eq('weak_monster')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('electric')
        expect(json[0]['weakness']).to eq('water')

        expect(json[1]['id']).to eq(12)
        expect(json[1]['name']).to eq('powerful_monster')
        expect(json[1]['power']).to eq(50)
        expect(json[1]['type']).to eq('fire')
        expect(json[1]['weakness']).to eq('water')
      end
    end
  end

  describe '#weakness' do
    context 'when there is invalid params' do
      it 'returns a missing param json' do
        get '/sort/weakness', {}

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Missing params')
      end
    end

    context 'when the user owns one monster' do
      before do
        FactoryGirl.create :monster
        FactoryGirl.create :user, email: "test_name_one", owned_monsters: [13]
      end

      it 'returns that monster correctly' do
        get '/sort/weakness?user_id=7&order=desc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(13)
        expect(json[0]['name']).to eq('test_monster_name')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('fire')
        expect(json[0]['weakness']).to eq('water')
      end
    end

    context 'when the user owns two monsters' do
      before do
        FactoryGirl.create :monster, name: "weak_monster", monstertype: 'electric', monsterweakness: 'wind'
        FactoryGirl.create :monster, name: "powerful_monster", monstertype: 'fire', monsterweakness: 'water'
        FactoryGirl.create :user, email: "test_name_two", owned_monsters: [14, 15]
      end
      it 'returns the monsters sorted properly' do
        get '/sort/weakness?user_id=8&order=asc'

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(14)
        expect(json[0]['name']).to eq('weak_monster')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('electric')
        expect(json[0]['weakness']).to eq('wind')

        expect(json[1]['id']).to eq(15)
        expect(json[1]['name']).to eq('powerful_monster')
        expect(json[1]['power']).to eq(50)
        expect(json[1]['type']).to eq('fire')
        expect(json[1]['weakness']).to eq('water')
      end
    end
  end
end