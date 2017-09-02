class ShortUrlsController < ApplicationController

	def index
		if params[:search]			
			key = params[:search].gsub('https://secure-ravine-12192.herokuapp.com/original?url=','') # RegEx, to get only my short_url 			
			short_url_id = ShortUrl.bijective_decode(key) 
			@urls = ShortUrl.where(unique_key: short_url_id)
		else		
			@urls = ShortUrl.all.order(count: :desc).limit(100) # All URLs order in descending order and limit 100
		end
	end

	def new
	end

	def create		
		if params[:search].present?			
			url = ShortUrl.get_host_without_www(params[:search]) # RegEx, to get only host name 'google' from 'www.google.com'
			uri = URI.parse(URI.encode(params[:search].strip))
			
			if uri.instance_of?(URI::Generic)
    			uri = URI::HTTP.build({:host => uri.to_s}) 
			end
			query = "#{uri.path}#{uri.query}#{uri.fragment}"
						

			if ShortUrl.last # Auto Increment my unique_id
				last_key = ShortUrl.last.unique_key+1 
				short_url   = ShortUrl.bijective_encode(last_key)
			else
				last_key = 125
				short_url = ShortUrl.bijective_encode(last_key)
			end

			if record = ShortUrl.find_by(url: url) # same url access twice				
				record.count = record.count + 1
				record.save
			else
				ShortUrl.create(url: url, short_url: short_url, count: 1, unique_key: last_key, query_string: query) # Create New short_url 
			end
		end

		redirect_to short_urls_path	
	end

	def original # For clicking on short_url and redirect to Original URL, along with counter increament 
		if params[:url].present? 
			single_url = ShortUrl.find_by(short_url: params[:url])	
			single_url.count = single_url.count+1
			single_url.save	
			url_id = ShortUrl.bijective_decode(single_url.short_url)
			host_url = "http://www.#{ShortUrl.find_by(unique_key: url_id).try(:url)}#{single_url.query_string}"
			redirect_to host_url
		end
	end
end
