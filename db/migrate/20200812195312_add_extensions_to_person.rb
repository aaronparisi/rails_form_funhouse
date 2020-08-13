class AddExtensionsToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :photo_ext, :string
    add_column :people, :desc_ext, :string
  end
end
