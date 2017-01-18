module Layouts
  class HeaderViewModel < ViewModel
    def initialize(vmc, breadcrumbs, current_user)
      @breadcrumbs = breadcrumbs
      @current_user = current_user
      super(vmc, :header)
    end

    def build
      create('layouts/header', view_models: {
        breadcrumbs: Layouts::BreadcrumbsViewModel.new(vmc, @breadcrumbs, @current_user),
        menus:       Layouts::MenusViewModel.new(vmc, @current_user)
      })
    end
  end
end
