module Pages
  class IndexViewModel < ViewModel
    def initialize(vmc, pages)
      @pages = pages
      super(vmc, 'index')
    end

    def build
      view_models =  {
          searchable_pages_table:  SearchablePagesTable::Component.new(vmc, :searchable_pages_table, @pages),
          static: Fields::StaticViewModel.new(vmc, "static", "hello"),
      }

      create('pages/index', view_models: view_models)
    end
  end
end