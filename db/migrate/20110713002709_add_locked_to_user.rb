class AddLockedToUser < ActiveRecord::Migration
  def self.up
    remove_column :users, :status
    add_column :users, :locked, :boolean
    
    User.all.each do |user|
      user.locked=false
      user.save!(:validate => false)
    end
  end

  def self.down
    add_column :users, :status,     :boolean
    remove_column :users, :locked
  end
end
