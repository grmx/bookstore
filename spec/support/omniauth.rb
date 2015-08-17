module Omniauth

  module Mock
    def auth_mock
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
        'provider' => 'facebook',
        'uid' => '12345678',
        'info' => {
          'name' => 'mock_user'
        },
        'credentials' => {
          'token' => 'mock_token',
          'secret' => 'mock_secret'
        }
      })
    end
  end

  module SessionHelpers
    def sign_in_facebook
      visit new_user_session_path
      expect(page).to have_content 'Sign in with Facebook'
      auth_mock
      click_link 'Sign in with Facebook'
    end
  end

end
