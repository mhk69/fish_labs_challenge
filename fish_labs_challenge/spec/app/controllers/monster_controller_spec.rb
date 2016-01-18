require 'spec_helper'

describe '/monster' do
  describe '#list' do
    context 'when there are no monsters' do
      it 'returns an empty json' do
        get '/monster/list', {}

        json = JSON.parse(last_response.body)

        expect(json).to eq([])
      end
    end

    context 'when there is one monster' do
      before do
        FactoryGirl.create :monster
      end

      it 'returns a json with the proper details' do
        get '/monster/list', {}

        json = JSON.parse(last_response.body)

        expect(json[0]['id']).to eq(1)
        expect(json[0]['name']).to eq('test_monster_name')
        expect(json[0]['power']).to eq(50)
        expect(json[0]['type']).to eq('fire')
      end
    end
  end

  describe '#create' do
    context 'when all arguments are passed in and valid' do
      before do
        @body = "{\"name\": \"test_name\", \"power\": \"100\", \"type\": \"fire\"}"
      end

      it 'returns that the monster was created succesfully' do
        post '/monster/create', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Monster created succesfully')
        expect(json['id']).to eq(2)
      end
    end

    context 'when an invalid type is sent' do
      it 'returns that type is not valid' do
        @body = "{\"name\": \"test_name\", \"power\": \"100\", \"type\": \"none\"}"

        post '/monster/create', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Invalid type')
      end

    context 'when invalid power is sent' do
      it 'returns that power is too high' do
        @body = "{\"name\": \"test_name\", \"power\": \"101\", \"type\": \"fire\"}"

        post '/monster/create', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Power too high or too low - must be between 0 and 100')
      end

      it 'returns that power is too low' do
        @body = "{\"name\": \"test_name\", \"power\": \"-1\", \"type\": \"fire\"}"

        post '/monster/create', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Power too high or too low - must be between 0 and 100')
      end
    end

    context 'when a monster is created with a name that exists' do
      it 'returns that monster already exists' do
        FactoryGirl.create :monster
        @body = "{\"name\": \"test_monster_name\", \"power\": \"100\", \"type\": \"fire\"}"

        post '/monster/create', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Monster with this name exists already - names must be unique')
      end
    end

    end
  end
end