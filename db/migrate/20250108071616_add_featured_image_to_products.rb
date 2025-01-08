class AddFeaturedImageToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :featured_image, :string
  end
end
