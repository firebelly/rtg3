class AddVariousIndices < ActiveRecord::Migration
  def change
    # various indices to speed up queries
    add_index :supporters, :supporter_type_id
    add_index :carts, :session_id
    add_index :donation_items, [:cart_id, :reason_id]
    add_index :pages, :slug, unique: true
    add_index :posts, [:post_type_id, :published]
    add_index :reasons, [:published, :promoted]
    add_index :reasons, [:published, :is_success, :promoted]
  end
end
