class CreatePerfis < ActiveRecord::Migration
  def self.up
    create_table :perfis do |t|
      t.string :descricao
      t.timestamps
    end
  end

  def self.down
    drop_table :perfis
  end
end
