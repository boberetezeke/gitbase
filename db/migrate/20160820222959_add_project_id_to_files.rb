class AddProjectIdToFiles < ActiveRecord::Migration[5.0]
  def change
    add_column :files, :project_directory_id, :integer
  end
end
