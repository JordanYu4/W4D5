require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  subject(:user) { User.create!(username: 'bob', password: '123456') }

  describe 'GET #index' do
    it 'renders the index page' do
      get :index

      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET #new' do
    it 'renders a new user page' do
      get :new

      expect(response).to render_template('new')
      expect(response).to have_http_status(200)
    end
  end

  describe 'POST #create' do
    it 'redirects to user index for valid user' do
      get :create, params: { user: { username: 'Jane', password: '123456' } }
      expect(response).to redirect_to(user_url(User.last))
      expect(response).to have_http_status(302)
    end

    it 'redirects to new user page for invalid user' do
      get :create, params: { user: { username: 'cat' } }
      expect(response).to redirect_to(new_user_url)
      expect(flash[:errors]).to be_present
    end
  end

  describe 'GET #show' do
    it 'renders the user\'s profile page' do
      get :show, params: { id: user.id }
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end



end
