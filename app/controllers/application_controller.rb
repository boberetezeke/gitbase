class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  if RUBY_ENGINE == 'opal'
    helper_method :current_user

    def current_user
      current_user_id = session[:current_user_id]
      if current_user_id
        User.find(current_user_id)
      else
        nil
      end
    end
  else
    before_action :authenticate_user!
    protect_from_forgery with: :exception, prepend: true
  end
end
