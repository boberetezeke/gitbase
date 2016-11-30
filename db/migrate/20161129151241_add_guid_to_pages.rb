class AddGuidToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :guid, :string
  end
end
