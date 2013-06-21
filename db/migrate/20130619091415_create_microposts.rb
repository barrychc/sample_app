class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
#  t.string :foobar, :length => 8
#  t.decimal :foobat, :precision => 4, :scale => 2
      t.timestamps #adds the magic created_at and updated_at columns
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
