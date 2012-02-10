class AddObsoleteFlagToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :obsolete, :boolean
  end

  def self.down
    remove_column :items, :obsolete
  end
end
