require 'rails_helper'

RSpec.describe 'Controllers', type: :request do
  describe 'PostsController' do
    describe '#index' do
      it 'returns a successful response' do
        get '/users/11/posts'
        expect(response).to have_http_status(:success)
      end

      it 'renders the index template' do
        get '/users/11/posts'
        expect(response).to render_template(:index)
      end
    end

    describe '#show' do
      it 'returns a successful response' do
        get '/users/1/posts/1'
        expect(response).to have_http_status(:success)
      end

      it 'renders the show template' do
        get '/users/1/posts/1'
        expect(response).to render_template(:show)
      end
    end
  end
end
