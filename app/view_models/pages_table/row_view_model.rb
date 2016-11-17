module PagesTable
  class RowViewModel < Table::RowViewModel
    def new_column(vmc, page, field_name, row_index, col_index, edit_state, show_link)
      id = "cell-#{row_index}-#{col_index}"
      puts "in new_column"
      if show_link
        Fields::LinkViewModel.new(vmc, id, page.send(field_name), show_link, ->{
          vmc.unregister_all_handlers
          application = Application.instance
          application.go_to_route(show_link, render_view: true, selector: "#app")
        })
      else
        Fields::TextViewModel.new(vmc, id, page, self, field_name, edit_state, show_link)
      end
    end
  end
end