module Pages
  class ShowViewModel < ViewModel
    def initialize(vmc, page)
      @page = page
      super(vmc, 'show')
    end

    def build
      view_models =  {
          title: Fields::StaticViewModel.new(vmc, "title", @page.title),
          body:  Fields::StaticViewModel.new(vmc, "body",  @page.body),
      }

      create('pages/show', view_models: view_models)
    end
  end
end
