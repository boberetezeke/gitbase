class PagesController < ApplicationController
  def index
    respond_to do |format|
      Pages::PaginatedQuery.new(params).query.then do |pages|
        format.html do
          @pages = pages.to_a
          render_vm { |vmc|
            if params[:as_selector]
              puts "building selector pages view model"
              Selector::PagesViewModel.new(vmc, :selector, pages, selected_page_lambda: params[:_selected_page_lambda])
            else
              puts "building index pages view model"
              Pages::IndexViewModel.new(vmc, pages)
            end
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
    respond_to do |format|
      Pages::PageQuery.new(params).query.then do |page|
        @page = page
        format.html do
          render_vm { |vmc| Pages::ShowViewModel.new(vmc, page) }
        end
        format.json do
          render json: page.to_json
        end
      end
    end
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