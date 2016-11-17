module Pages
  class IndexViewModel < ViewModel
    def initialize(vmc, pages)
      @pages = pages
      super(vmc, 'index')
    end

    def build
      view_models =  {
          pages_table:  PagesTable::TableViewModel.new(vmc, @pages),
          static: Fields::StaticViewModel.new(vmc, "static", "hello"),
      }

      create('pages/index', view_models: view_models)
    end
  end
end