module PagesTable
  class TableViewModel < Table::TableViewModel
    titles               ["Title", "GUID"]
    columns              [:title, :guid]

    show_link_lambda     ->(page) { "/pages/#{page.id}" }
    new_link_lambda      ->       { "/pages/new" }
    edit_link_lambda     ->(page) { "/pages/#{page.id}/edit" }
    delete_link_lambda   ->(page) { "/pages/#{page.id}" }

    def initialize(vmc, pages, id: :pages_table)
      @pages = pages
      super(vmc, id, additional_states: {filter_by: ""})
    end

    def build
      create(@pages, view_name: "pages_table/table")
    end

    def new_row(vmc, table, page, row_index, edit_inline)
      RowViewModel.new(vmc, "page-#{page.id}", table, page, row_index, get_show_link_lambda, get_edit_link_lambda, get_delete_link_lambda, 0, :display, edit_inline)
    end
  end
end