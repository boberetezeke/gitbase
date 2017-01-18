module Layouts
  class ApplicationContentViewModel < ViewModel
    def initialize(vmc, breadcrumbs, current_user, content_view_model)
      @breadcrumbs = breadcrumbs
      @current_user = current_user
      @content_view_model = content_view_model

      super(vmc, :app_content)
    end

    def build
      create('layouts/application_content', view_models: {
          header:      Layouts::HeaderViewModel.new(vmc, @breadcrumbs, @current_user),
          content:     @content_view_model
      })
    end
  end
end