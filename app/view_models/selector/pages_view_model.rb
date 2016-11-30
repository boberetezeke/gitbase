module Selector
  class PagesViewModel < ViewModel
    def build
      create("selector/pages", view_models: [
          PagesTable::TableViewModel.new(vmc, [])
      ])
    end


    def modal_closed
    end
  end
end