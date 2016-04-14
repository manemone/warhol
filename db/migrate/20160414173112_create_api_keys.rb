class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.string :access_token, null: false
      t.datetime :expires_at, null: false
      t.integer :user_id
      t.boolean :active, default: false, null: :false
    end

    add_index :api_keys, :user_id, name: "idx_user"
    add_index :api_keys, [:user_id, :access_token], name: "idx_user_token", unique: true
  end
end
