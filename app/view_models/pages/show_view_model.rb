module Pages
  class ShowViewModel < ViewModel
    def initialize(vmc, page, pages)
      @page = page
      @pages = pages
      super(vmc, 'show', {modal_state: :off})
    end

    def build
      show_modal = Fields::LinkViewModel.new(vmc, :show_modal, "Show Modal", "#", click_lambda: ->{
        puts "link clicked"
        self.update(modal_state: :on)
      })

      form = form_for @page, vmc: vmc do |f|
        f.text_field  :title
        f.text_area   :body
        f.submit      :save, 'Create'

        f.view_model(show_modal)
      end

      view_models = {form: form}

      if modal_state == :on
        pages_selector = Selector::PagesViewModel.new(vmc, :pages_selector, @pages,
                                                      selected_page_lambda: ->(page) {
                                                        puts "selected page: #{page.guid}"
                                                        @modal.hide
                                                      })
        @modal = Modal::ModalViewModel.new(vmc, :modal, pages_selector, "Select Pages", "Ok")
        view_models = view_models.merge(modal: @modal)
      end

      create('pages/show', view_models: view_models, values: {show_modal: show_modal} )
    end

    def getLink
      self.update(modal_state: :on)
      "http://my-new-link"
    end

    def modal_closed
      puts "modal closed"
      update(modal_state: :off)
    end

    def register_handlers
      `new PageEditor(#{->{self.getLink}})`
    end
  end
end
