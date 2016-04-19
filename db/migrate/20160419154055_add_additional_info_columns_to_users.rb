class AddAdditionalInfoColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string, after: :name
  end
end
