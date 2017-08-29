class CreateShortUrls < ActiveRecord::Migration[5.0]
  def change
    create_table :short_urls do |t|
      t.string :url
      t.integer :short_url_id, limit: 8
      t.integer :count

      t.timestamps
    end
  end
end
