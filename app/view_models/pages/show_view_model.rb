module Pages
  class SelectorModal < ViewModel
    def initialize(vmc, pages)
      # @pages = pages
      super(vmc, :selector_modal, {show: :off})
    end

    def build
      if show == :loading
        puts "Pages::SelectorModal#build: loading"
        #vmc.create_controller_for_route(pages_path) do |pages_vmc|
        vmc.create_controller_for_route("/pages?as_selector=true", additional_params: {
            selected_page_lambda: ->(page) {
              puts "in Pages::SelectorModal with page: #{page}"
              stash(selected_page: page)
              modal = unstash(modal: nil)
              modal.hide
            }
        }) do |pages_vmc|
          stash(pages_vmc: pages_vmc)
          puts "loaded with view model: #{pages_vmc.view_model}"

          update(show: :on)
        end

        view_models = []
      elsif show == :on

        #pages_selector = Selector::PagesViewModel.new(vmc, :pages_selector, @pages,
        #                                              selected_page_lambda: ->(page) {
        #                                                puts "selected page: #{page.guid}"
        #                                                @page = page
        #                                                @modal.hide
        #                                              })

        # @modal = Modal::ModalViewModel.new(vmc, :modal, pages_selector, "Select Pages", "Ok")
        pages_vmc = unstash(pages_vmc: nil)
        puts "show:on with view model: #{pages_vmc.view_model}"
        modal = Modal::ModalViewModel.new(vmc, :modal, pages_vmc.view_model, "Select Pages", "Ok")
        stash(modal: modal)
        view_models = [ modal ]
      else
        view_models = []
      end
      create('pages/selector_modal', view_models: view_models, values: {show: show})
    end

    def modal_closed
      selected_page = unstash(selected_page: nil)
      puts("modal closed, page selected: #{selected_page}")
      parent.selector_modal_closed(selected_page)
      stash_clear(:selected_page)
      update(show: :off)
    end
  end

  class ShowViewModel < ViewModel
    def initialize(vmc, page, pages)
      @page = page
      @pages = pages
      super(vmc, 'show', {modal_state: :off})
    end

    def build
      @selector_modal = SelectorModal.new(vmc, @pages)

      form = form_for @page, vmc: vmc do |f|
        f.text_field  :title
        f.text_area   :body
        f.submit      :save, 'Create'
      end

      create('pages/show', view_models: {form: form, selector_modal: @selector_modal} )
    end

    def getLink(update_link_lambda)
      stash(update_link_lambda: update_link_lambda)
      @selector_modal.update(show: :loading)
    end

    def selector_modal_closed(page)
      if page
        puts "selector modal closed: page=#{page}"
        update_link_lambda = unstash(update_link_lambda: nil)
        update_link_lambda.call("/pages/#{page.id}") if update_link_lambda
      end
    end

    def after_mount
      puts "in ShowViewModel#after_mount"
      `new PageEditor(#{->(link_function){self.getLink(link_function)}})`
    end

    def register_handlers
    end
  end
end
