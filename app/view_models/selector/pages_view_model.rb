module Selector
  class PagesViewModel < ViewModel
    def initialize(vmc, id, pages, selected_page_lambda: nil)
      @selected_page_lambda = selected_page_lambda
      @pages = pages
      super(vmc, id)
    end

    def build
      create("selector/pages", view_models: [
          SearchablePagesTable::Component.new(vmc, :searchable_pages_table, @pages, selected_page_lambda: @selected_page_lambda)
      ])
    end


    def modal_closed
    end
  end
end