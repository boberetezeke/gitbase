class ProjectDirectoriesController < ApplicationController
  def index
    @project_directories = ProjectDirectory.all
  end

  def new
    @project_directory = ProjectDirectory.new
  end

  def create
    @project_directory = ProjectDirectory.new(project_directory_params)
    if @project_directory.save
      redirect_to @project_directory
    else
      render :new
    end
  end

  def edit
    @project_directory = ProjectDirectory.find(params[:id])
  end

  def update
    @project_directory = ProjectDirectory.new(project_directory_params)
    if @project_directory.save
      redirect_to @project_directory
    else
      render :edit
    end
  end

  def show
    @project_directory = ProjectDirectory.find(params[:id])
  end
end
