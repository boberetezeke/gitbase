module PagesTable
  class TableViewModel < Table::TableViewModel
    titles               ["Title", "GUID"]
    columns              [:title, :guid]
    show_index           0

    show_link_lambda     ->(page) { "/pages/#{page.id}" }
    # new_link_lambda      ->       { "/pages/new" }
    edit_link_lambda     ->(page) { "/pages/#{page.id}/edit" }
    delete_link_lambda   ->(page) { "/pages/#{page.id}" }

    attr_reader :selected_page_lambda

    def initialize(vmc, pages, id: :pages_table, selected_page_lambda: nil)
      @pages = pages
      @selected_page_lambda = selected_page_lambda
      @new_link_lambda = ->{ "/pages/new" } unless @selected_page_lambda
      super(vmc, id, additional_states: {filter_by: ""})
    end

    def build
      create(@pages, view_name: "pages_table/table")
    end

    def new_header(vmc)
      if selected_page_lambda
        Table::HeaderViewModel.new(vmc, get_titles, true)
      else
        super
      end
    end

    def new_row(vmc, table, page, row_index, edit_inline)
      RowViewModel.new(vmc, "page-#{page.id}", table, page, row_index)
    end
  end
end