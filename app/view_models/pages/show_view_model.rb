module Pages
  class ShowViewModel < ViewModel
    def initialize(vmc, page)
      @page = page
      super(vmc, 'show', {modal_state: :off})
    end

    def build
      show_modal = Fields::LinkViewModel.new(vmc, :show_modal, "Show Modal", "#", click_lambda: ->{
        puts "link clicked"
        self.update(modal_state: :on)
      })
      show = self
      form = Fields::FormViewModel.new(vmc, :page, object: @page) do |f|
        [
          Fields::TextViewModel.new(vmc,          :title, object: @page, edit_state: :edit, form: f),
          Fields::TextAreaViewModel.new(vmc,      :body,  object: @page, edit_state: :edit, form: f),
          show_modal,
          Fields::SubmitButtonViewModel.new(vmc,  :save, "Create", form: f, on_click_lambda: ->{
             puts "submit clicked"
          })
        ]
      end
      view_models = {form: form}

      if modal_state == :on
        pages_selector = Selector::PagesViewModel.new(vmc, :pages_selector)
        modal = Modal::ModalViewModel.new(vmc, :modal, pages_selector, "Select Pages", "Ok")
        view_models = view_models.merge(modal: modal)
      end

      create('pages/show', view_models: view_models, values: {show_modal: show_modal} )
    end

    def modal_closed
      puts "modal closed"
      update(modal_state: :off)
    end
  end
end
