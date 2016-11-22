module Pages
  class ShowViewModel < ViewModel
    def initialize(vmc, page)
      @page = page
      super(vmc, 'show')
    end

    def build
      view_models =  [
          Fields::TextViewModel.new(vmc, @page, :title),
          Fields::TextAreaViewModel.new(vmc, @page, :body, edit_state: :edit),
          Fields::SubmitButtonViewModel.new(vmc, :save, "Create", on_click_lambda: ->{
            puts "submit clicked"
          })
      ]

      create('pages/show', view_models: view_models)
    end
  end
end
