require 'rails_helper'

RSpec.describe "Users" do
  it "creates a User and redirects to the User's page" do
    get users_signup_path

    expect(response).to render_template(:new)

    post_params = {
      params: {
        user: {
          handle: 'Bibi',
          first_name: 'Bibib',
          last_name: 'Testing',
          email: 'gsd@gsd.com',
          password: '123456',
          password_confirmation: '123456'
        }
      }
    }
    post users_path, post_params

    expect(session[:user_id]).not_to be_nil
    expect(response).to redirect_to(assigns(:user))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include('New recipe')

  end

  it 'renders New when User params are empty' do
    get users_signup_path

    expect(response).to render_template(:new)

    post_params = {
      params: {
        user: {
          handle: '',
          first_name: '',
          last_name: '',
          email: '',
          password: '',
          password_confirmation: ''
        }
      }
    }
    post users_path, post_params

    expect(session[:user_id]).to be_nil
    expect(response).to render_template(:new)

    expect(response.body).to include('New user')
  end
end
