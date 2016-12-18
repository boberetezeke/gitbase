module PagesTable
  class SelectActionColumnViewModel < ViewModel
    def initialize(vmc, object, selected_page_lambda)
      @object = object
      @selected_page_lambda = selected_page_lambda
      super(vmc, :select_action_column)
    end

    def build
      create("pages_table/select_action_column", view_models: [
        Fields::LinkViewModel.new(vmc, :select_button, "Select", "#", click_lambda: ->{ @selected_page_lambda.call(@object) })
      ])
    end
  end
end