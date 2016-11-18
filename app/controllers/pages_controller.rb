class PagesController < ApplicationController
  def index
    @pages = Page.all
    render_vm { |vmc| Pages::IndexViewModel.new(vmc, @pages) }
  end

  def show
    @page = Page.find(params[:id])
    render_vm { |vmc| Pages::ShowViewModel.new(vmc, @page) }
  end
end