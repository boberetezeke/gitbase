class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  if RUBY_ENGINE != 'opal'
    before_action :authenticate_user!
    protect_from_forgery with: :exception, prepend: true
  end

  def render_vm
    TopLevelViewModelController.render_view_model(self, action_name, params, "#app") do |vmc|
      yield(vmc)
    end
  end
end
