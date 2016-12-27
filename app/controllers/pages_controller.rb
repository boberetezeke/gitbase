class PagesController < ApplicationController
  def index
    respond_to do |format|
      Pages::PaginatedQuery.new(params).query.then do |pages|
        format.html do
          @pages = pages.to_a
          render_vm { |vmc|
            Pages::IndexViewModel.new(vmc, pages)
          }
        end
        format.json do
          render json: pages.to_json
        end
      end
    end
  end

  def tables
    @pages = Page.all
    render_vm { |vmc| Pages::TablesViewModel.new(vmc, @pages) }
  end

  def show
    # @page = Page.where(id: params[:id]).first || Page.where(guid: params[:id]).first
    @page = Page.find(params[:id])
    @pages = Page.all
    puts "params[:id] = #{params[:id]}"
    puts "@page = #{@page}"
    render_vm { |vmc| Pages::ShowViewModel.new(vmc, @page, @pages) }
  end

  def new
    @page = Page.new
    @pages = Page.all
    render_vm { |vmc| Pages::ShowViewModel.new(vmc, @page, @pages) }
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
    respond_to do |format|
      if @page.update(page_params)
        format.html do
          redirect_to pages_path
        end
        format.json do
          render json: @page
        end
      else
        format.html { render :show }
        format.json { @page.errors }
      end
    end
  end

  private

  def page_params
    params.require(:page).permit(:title, :body, :guid)
  end
end