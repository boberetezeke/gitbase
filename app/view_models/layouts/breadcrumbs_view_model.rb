module Layouts
  class BreadcrumbsViewModel < ViewModel
    def initialize(vmc, breadcrumbs, current_user)
      @breadcrumbs = breadcrumbs
      @current_user = current_user

      super(vmc, :breadcrumbs)
    end

    def breadcrumbs_html_safe
      @breadcrumbs.map do |title, link|
        if link
          link_to(title, link)
        else
          title
        end
      end.join(" | ").html_safe
    end

    def build
      create 'layouts/breadcrumbs', values: { breadcrumbs_html_safe: breadcrumbs_html_safe, current_user: @current_user }
    end
  end
end