class AddQueryStringToShortUrls < ActiveRecord::Migration[5.0]
  def change
  	add_column :short_urls, :query_string, :string
  end
end
