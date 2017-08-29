class ChangeShortUrlAtble < ActiveRecord::Migration[5.0]
  def change
  	change_column :short_urls, :count, :integer, default: 0
  end
end
