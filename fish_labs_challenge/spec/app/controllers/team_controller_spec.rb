require 'spec_helper'

describe '/team' do
  describe '#add' do
    context 'when invalid params are sent' do
      it 'returns an error json' do
        @body = "{\"username\": \"test_email\", \"password\":\"test_pw\", \"monster_id\":\"-1\"}"

        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('That user or monster does not exist')
      end
    end

    context 'when a user has no monsters on a team with valid params' do
      before do
        FactoryGirl.create :user
        FactoryGirl.create :monster

        @body = "{\"username\": \"test_email\", \"password\":\"test_pw\", \"monster_id\":\"16\"}"
      end
      it 'adds a monster to team 1' do
        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Added to team 1')
      end
    end

    context 'when a user has one full team' do
      before do
        FactoryGirl.create :user, email: "test2", team_one: [1, 2, 3]
        FactoryGirl.create :monster
        @body = "{\"username\": \"test2\", \"password\":\"test_pw\", \"monster_id\":\"17\"}"
      end

      it 'adds a monster to team 2' do
        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Added to team 2')
      end
    end

    context 'when a user has 3 full teams and no owned monsters' do
      before do
        FactoryGirl.create :user, email: "test3", team_one: [1, 2, 3], team_two: [1, 2, 3], team_three: [1, 2, 3]
        FactoryGirl.create :monster
        @body = "{\"username\": \"test3\", \"password\":\"test_pw\", \"monster_id\":\"18\"}"
      end

      it 'returns a json stating the monster is in owned monsters' do
        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Added this monster to owned monsters')
      end
    end

    context 'when a user has 3 full teams and full owned monsters' do
      before do
        FactoryGirl.create :user, email: "test_full", team_one: [1, 2, 3], team_two: [1, 2, 3], team_three: [1, 2, 3], owned_monsters: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        FactoryGirl.create :monster
        @body = "{\"username\": \"test_full\", \"password\":\"test_pw\", \"monster_id\":\"19\"}"
      end

      it 'returns a json stating the user can not have more monsters' do
        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('You own too many monsters')
      end
    end

    context 'when a user has that monster already added' do
      before do
        FactoryGirl.create :user, email: "test4", team_one: [20]
        FactoryGirl.create :monster

        @body = "{\"username\": \"test4\", \"password\":\"test_pw\", \"monster_id\":\"20\"}"
      end

      it 'returns a json stating it already exists' do
        post '/team/add', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('This monster is in a team')
      end
    end
  end

  describe '#delete_from_team' do
    context 'when invalid params are sent' do
      it 'returns an error json' do
        @body = "{\"username\": \"test_email\", \"password\":\"test_pw\", \"monster_id\":\"-1\"}"

        post '/team/delete_from_team', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('That user or monster does not exist')
      end
    end

    context 'when a valid param is sent' do
      before do
        FactoryGirl.create :user, email: "test5", team_one: [9]
        FactoryGirl.create :monster
        @body = "{\"username\": \"test5\", \"password\":\"test_pw\", \"monster_id\":\"21\"}"
      end

      it 'returns a json stating the monster was deleted' do
        post '/team/delete_from_team', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Deleted monster from a team')
      end
    end
  end

  describe '#delete' do
    context 'when invalid params are sent' do
      it 'returns an error json' do
        @body = "{\"username\": \"test_email\", \"password\":\"test_pw\", \"monster_id\":\"-1\"}"

        post '/team/delete', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('That user or monster does not exist')
      end
    end

    context 'when a valid param is sent' do
      before do
        FactoryGirl.create :user, email: "test6", team_one: [10]
        FactoryGirl.create :monster
        @body = "{\"username\": \"test6\", \"password\":\"test_pw\", \"monster_id\":\"22\"}"
      end

      it 'returns a json stating the monster was deleted' do
        post '/team/delete', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Deleted monster')
      end
    end
  end

end