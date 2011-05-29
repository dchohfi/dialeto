class CreatePropagandas < ActiveRecord::Migration
  def self.up
    create_table :propagandas do |t|
      t.string :local_path
      t.string :nome
      t.timestamps
    end
  end

  def self.down
    drop_table :propagandas
  end
end
