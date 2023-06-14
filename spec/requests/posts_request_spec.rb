require 'rails_helper'

  RSpec.describe 'Controllers', type: :request do
    describe 'PostsController' do
      describe '#index' do
        it 'returns a successful response' do
          get '/users/1/posts'
          expect(response).to have_http_status(:success)
        end
  
        it 'renders the index template' do
          get '/users/1/posts'
          expect(response).to render_template(:index)
        end
  
        it 'includes correct placeholder text in the response body' do
          get '/users/1/posts'
          expect(response.body).to include('List of all posts and comment of a user')
        end
      end
  
      describe '#show' do
        it 'returns a successful response' do
          get "/users/1/posts/4"
          expect(response).to have_http_status(:success)
        end
  
        it 'renders the show template' do
          get "/users/1/posts/4"
          expect(response).to render_template(:show)
        end
  
        it 'includes correct placeholder text in the response body' do
          get "/users/1/posts/4"
          expect(response.body).to include('>Details of a selected post')
        end
      end
    end
  end