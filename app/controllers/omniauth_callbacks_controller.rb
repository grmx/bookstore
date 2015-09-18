class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    facebook_sign_in if @user.persisted?
  end

  private

  def facebook_sign_in
    sign_in_and_redirect @user, event: :authentication
    set_flash_message(:notice, :success,
                      kind: 'Facebook') if is_navigational_format?
  end
end
