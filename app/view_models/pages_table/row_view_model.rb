module PagesTable
  class RowViewModel < Table::RowViewModel
    def new_column(vmc, page, field_name, row_index, col_index, edit_state, show_link)
      id = "cell-#{row_index}-#{col_index}"
      puts "in new_column"
      if show_link
        Fields::LinkViewModel.new(vmc, id, page.send(field_name), show_link, click_lambda: ->{
          vmc.unregister_all_handlers
          application = Application.instance
          application.go_to_route(show_link, render_view: true, selector: "#app")
        })
      else
        Fields::TextViewModel.new(vmc, page, field_name, id: id)
      end
    end
  end
end