class ShortUrlsController < ApplicationController

	def index
		@urls = ShortUrl.all.order(count: :desc)
	end

	def new
	end

	def create		
		if params[:search].present?			
			url = ShortUrl.get_host_without_www(params[:search]).gsub(/.com/,'') 
			if ShortUrl.last
				last_key = ShortUrl.last.unique_key+1 
				short_url   = ShortUrl.bijective_encode(last_key)
			else
				last_key = 125
				short_url = ShortUrl.bijective_encode(last_key)
			end

			if record = ShortUrl.find_by(url: url)				
				record.count = record.count + 1
				record.save
			else
				ShortUrl.create(url: url, short_url: short_url, count: 1, unique_key: last_key)
			end
		end

		redirect_to short_urls_path	
	end
end
