class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.references :Category
      t.references :User
      t.timestamps
    end
  end
end
