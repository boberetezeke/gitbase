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
      super(vmc, id)
    end

    def build
      create(@pages, "pages_table/table", true)
    end

    def new_row(vmc, table, page, row_index, edit_inline)
      RowViewModel.new(vmc, "page-#{page.id}", table, page, row_index, show_link_lambda, edit_link_lambda, delete_link_lambda, 0, :display, edit_inline)
    end
  end
end