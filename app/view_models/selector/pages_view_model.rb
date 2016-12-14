module Selector
  class PagesViewModel < ViewModel
    def initialize(vmc, id, pages)
      @pages = pages
      super(vmc, id)
    end

    def build
      create("selector/pages", view_models: [
          SearchablePagesTable::Component.new(vmc, :searchable_pages_table, @pages)
      ])
    end


    def modal_closed
    end
  end
end