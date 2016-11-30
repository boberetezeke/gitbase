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
      fields = PagesForm::FormViewModel.new(vmc, @page, show_modal)
      form = Fields::FormViewModel.new(vmc, :page, @page, fields)
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
