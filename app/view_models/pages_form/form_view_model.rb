module PagesForm
  class FormViewModel < ViewModel
    def initialize(vmc, page)
      @page = page
      super(vmc, :page)
    end

    def build
      view_models =  [
        Fields::TextViewModel.new(vmc, @page, :title, edit_state: :edit),
        Fields::TextAreaViewModel.new(vmc, @page, :body, edit_state: :edit),
        Fields::SubmitButtonViewModel.new(vmc, :save, "Create", on_click_lambda: ->{
          puts "submit clicked"
        })
      ]
      create("pages_form/form", view_models: view_models)
    end
  end
end
