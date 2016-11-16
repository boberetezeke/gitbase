class AddFileModel < ActiveRecord::Migration[5.0]
  def change
    create_table :files do |t|
      t.string :path
      t.text   :content
    end
  end
end
