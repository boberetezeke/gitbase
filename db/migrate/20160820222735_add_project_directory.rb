class AddProjectDirectory < ActiveRecord::Migration[5.0]
  def change
    create_table :project_directory do |t|
      t.string :path
      t.string :project_type
    end
  end
end
