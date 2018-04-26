class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.text :post_name
      t.text :content
      t.integer :user_id
     end 
  end
end
