module Pages
  class ShowViewModel < ViewModel
    def initialize(vmc, page)
      @page = page
      super(vmc, 'show')
    end

    def build
      fields = PagesForm::FormViewModel.new(vmc, @page)
      form = Fields::FormViewModel.new(vmc, :page, @page, fields)
      create('pages/show', view_models: {form: form} )
    end
  end
end
