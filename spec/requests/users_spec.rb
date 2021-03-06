require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
    end
    it 'renders the index template' do
      get '/'
      expect(response).to render_template('index')
    end
  end
  describe 'GET /users/:id' do
    it 'returns http success' do
      get '/users/1'
      expect(response).to have_http_status(:success)
    end
    it 'renders the show template' do
      get '/users/1'
      expect(response).to render_template('show')
    end
  end
end
