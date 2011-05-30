class AddImageToPropaganda < ActiveRecord::Migration
  def self.up
    add_column :propagandas, :image_file_name,    :string
    add_column :propagandas, :image_content_type, :string
    add_column :propagandas, :image_file_size,    :integer
    add_column :propagandas, :image_updated_at,   :datetime
  end

  def self.down
    remove_column :propagandas, :image_file_name
    remove_column :propagandas, :image_content_type
    remove_column :propagandas, :image_file_size
    remove_column :propagandas, :image_updated_at
  end
end
