class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.references :User
      t.references :Post

      t.timestamps
    end
  end
end
