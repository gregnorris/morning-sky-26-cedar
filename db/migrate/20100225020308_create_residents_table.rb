class CreateResidentsTable < ActiveRecord::Migration
  def self.up
    create_table :residents do |t|
      t.integer :recipient_id
      t.string  :gender, :limit => 1
      t.integer :age
      t.boolean :aboriginal
      t.boolean :recent_immigrant
      t.boolean :disabled
      t.integer :category
      t.timestamps
    end
  end

  def self.down
    drop_table :residents
  end
end
