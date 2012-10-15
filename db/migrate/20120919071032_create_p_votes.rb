class CreatePVotes < ActiveRecord::Migration
  def change
    create_table :p_votes do |t|
      t.references :User
      t.references :Post
      t.timestamps
    end
  end
end
