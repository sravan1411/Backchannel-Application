class CreateCVotes < ActiveRecord::Migration
  def change
    create_table :c_votes do |t|
      t.references :User
      t.references :Comment


      t.timestamps
    end
  end
end
