class PagesController < ApplicationController
  def index
    @pages = Page.all
    TopLevelViewModelController.render_view_model(self, :index, params, "#app") do |vmc|
      Pages::IndexViewModel.new(vmc, @pages)
    end
  end

  def show
    @page = Page.find(params[:id])
  end
end