class ShortUrlsController < ApplicationController

	def index
		@urls = ShortUrl.all.order(count: :desc)
	end

	def new
	end

	def create		
		url        = ShortUrl.get_host_without_www(params[:search]).gsub(/.com/,'') if params[:search]
		url_id     = ShortUrl.bijective_decode(url)	

		if record = ShortUrl.find_by(short_url_id: url_id)				
			record.count = record.count + 1
			record.save
		else
			ShortUrl.create(url: params[:search], short_url_id: url_id, count: 1)
		end

		redirect_to short_urls_path	
	end
end
