class AddEmailCheckboxToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :people, :subscribe_to_emails, :boolean
  end
end
