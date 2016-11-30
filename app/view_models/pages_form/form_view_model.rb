module PagesForm
  class FormViewModel < ViewModel
    def initialize(vmc, page, show_modal)
      @page = page
      @show_modal = show_modal
      super(vmc, :page, {modal_state: :off})
    end

    def build
      view_models =  [
        Fields::TextViewModel.new(vmc,          :title, object: @page, edit_state: :edit),
        Fields::TextAreaViewModel.new(vmc,      :body,  object: @page, edit_state: :edit),
        Fields::SubmitButtonViewModel.new(vmc,  :save, "Create", on_click_lambda: ->{
          puts "submit clicked"
        }),
        @show_modal
      ]

      create("pages_form/form", view_models: view_models)
    end
  end

  def modal_closed
    update(modal_state: :off)
  end
end
