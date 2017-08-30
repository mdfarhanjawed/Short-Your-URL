class AddUniqueKeyToShortUrls < ActiveRecord::Migration[5.0]
  def change
  	add_column :short_urls, :unique_key, :integer, default: 125
  	rename_column :short_urls, :short_url_id, :short_url
  	change_column :short_urls, :short_url, :string
  end
end
