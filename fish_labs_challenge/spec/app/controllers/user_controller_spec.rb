require 'spec_helper'

describe '/user' do

  describe '#register' do
    context 'when an argument is not present' do
      before do
        @body = "{\"username\": \"test\"}"
      end

      it 'returns an error json' do
        post '/user/register', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Missing some arguments')
      end
    end

    context 'when both arguments are present' do
      before do
        @body = "{\"username\": \"test\", \"password\": \"test_pw\"}"
      end

      it 'returns a message json' do
        post '/user/register', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('Succesfully added this user')
        expect(json['id']).to eq(16)
      end
    end

    context 'when a user with that email already exists' do
      before do
        FactoryGirl.create :user

        @body = "{\"username\": \"test_email\", \"password\": \"test_pw\"}"
      end

      it 'returns a message json' do
        post '/user/register', @body

        json = JSON.parse(last_response.body)

        expect(json['message']).to eq('This user already exists')
      end
    end
  end
end