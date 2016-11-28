class PagesController < ApplicationController
  def index
    @pages = Page.all
    render_vm { |vmc| Pages::IndexViewModel.new(vmc, @pages) }
  end

  def show
    @page = Page.find(params[:id])
    render_vm { |vmc| Pages::ShowViewModel.new(vmc, @page) }
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to pages_path
    else
      render :show
    end
  end

  def update
    @page = Page.find(params[:id])
    if @page.update(page_params)
      redirect_to pages_path
    else
      render :show
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body)
  end
end