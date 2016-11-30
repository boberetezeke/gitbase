module Selector
  class PagesViewModel < ViewModel
    def build
      create("selector/pages", view_models: [
          Fields::TextViewModel.new(vmc, :search, value: "", on_change_lambda: ->(search){ search_changed(search) }, edit_state: :edit),
          PagesTable::TableViewModel.new(vmc, [])
      ])
    end

    def search_changed(search)
      puts "search value: #{search.get_value}"
    end

    def modal_closed
    end
  end
end