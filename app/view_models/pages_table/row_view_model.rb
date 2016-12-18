module PagesTable
  class RowViewModel < Table::RowViewModel
    def new_action_column(vmc, table, object, edit_link, delete_link, edit_inline, edit_state)
      if table.selected_page_lambda
        SelectActionColumnViewModel.new(vmc, object, table.selected_page_lambda)
      else
        super
      end
    end

    def new_column(vmc, page, field_name, row_index, col_index, edit_state, show_link)
      id = "cell-#{row_index}-#{col_index}"
      if show_link
        Fields::LinkViewModel.new(vmc, id, page.send(field_name), show_link, click_lambda: ->{
          vmc.unregister_all_handlers
          application = Application.instance
          application.go_to_route(show_link, render_view: true, selector: "#app")
        })
      else
        Fields::TextViewModel.new(vmc, field_name, object: page, id: id)
      end
    end
  end
end