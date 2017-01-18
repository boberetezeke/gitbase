module Layouts
  class MenusViewModel < ViewModel
    def initialize(vmc, current_user)
      @current_user = current_user
      super(vmc, :breadcrumbs)
    end

    def build
      create 'layouts/menus', values: { current_user: @current_user }
    end
  end
end
