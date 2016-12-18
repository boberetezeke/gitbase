module SearchablePagesTable
  class Component < ViewModel
    def initialize(vmc, id, pages, selected_page_lambda: nil)
      @pages = pages
      @selected_page_lambda = selected_page_lambda
      super(vmc, id, {filter_by: ["", :string]})
    end

    def build
      search = Fields::TextViewModel.new(vmc, :search, value: filter_by, on_change_lambda: ->(search){ search_changed(search) }, edit_state: :edit)

      filter_str = filter_by.to_s.strip
      puts "filter_by: #{filter_by}, filter_str: #{filter_str}"
      if filter_str != ""
        puts "filtering by: #{filter_str}"
        pages = @pages.select{|page| page.title =~ /#{filter_str}/}
      else
        pages = @pages
      end
      pages_table = PagesTable::TableViewModel.new(vmc, pages, selected_page_lambda: @selected_page_lambda)

      create("searchable_pages_table/component", view_models: [search, pages_table])
    end

    def search_changed(search)
      update(filter_by: search.get_value)
    end
  end
end