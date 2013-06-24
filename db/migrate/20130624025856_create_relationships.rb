class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :follower_id
      t.integer :followed_id

      t.timestamps
    end
    
    #add manually
    add_index :relationships, :follower_id
    add_index :relationships, :followed_id
    add_index :relationships, [:follower_id, :followed_id], unique: true
  end
end
#rails generate model Relationship follower_id:integer followed_id:integer
=begin
      # invoke  active_record
      # create    db/migrate/20130624025856_create_relationships.rb
      # create    app/models/relationship.rb
      # invoke    rspec
      # create      spec/models/relationship_spec.rb
=end
