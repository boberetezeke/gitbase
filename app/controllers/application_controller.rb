class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  if RUBY_ENGINE != 'opal'
    protect_from_forgery with: :exception
  end

  def render_vm
    TopLevelViewModelController.render_view_model(self, action_name, params, "#app") do |vmc|
      yield(vmc)
    end
  end
end
