class ShortUrlsController < ApplicationController

	def index
		@urls = ShortUrl.all
	end

	def new
	end

	def create		
		url        = ShortUrl.get_host_without_www(params[:search]).gsub(/.com/,'') if params[:search]

		url_id     = ShortUrl.bijective_decode(url)		
		record     = ShortUrl.create(url: params[:search], short_url_id: url_id)
		redirect_to short_urls_path				
	end
end
