require 'rails_helper'

RSpec.describe 'Controllers', type: :request do
  describe 'UsersController' do
    describe '#index' do
      it 'returns a successful response' do
        get '/users'
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get '/users'
        expect(response).to render_template(:index)
      end

      it 'includes correct placeholder text in the response body' do
        get '/users'
        expect(response.body).to include('The list of all users')
      end
    end

    describe '#show' do
      it 'returns a successful response' do
        user = User.create(name: 'John')
        get "/users/1"
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        user = User.create(name: 'John')
        get "/users/1"
        expect(response).to render_template(:show)
      end

      it 'includes correct placeholder text in the response body' do
        user = User.create(name: 'John')
        get "/users/1"
        expect(response.body).to include('Details for a given users with post')
      end
    end
  end
end