class ShortUrl < ApplicationRecord
	validates_uniqueness_of :short_url

	ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
	  # make your own alphabet using:	  

	def self.bijective_encode(i) # getting short URL from unique_id	  
	  # converting number to string
	  return ALPHABET[0] if i == 0
	  s = ''
	  base = ALPHABET.length
	  while i > 0
	    s << ALPHABET[i.modulo(base)]
	    i /= base
	  end
	  s.reverse
	end

	def self.bijective_decode(s) # Getting the unique_id back for Identification
	  # converting from string to number for identification	
	  return nil if s.include? "."
	  i = 0
	  base = ALPHABET.length
	  s.each_char { |c| i = i * base + ALPHABET.index(c) }
	  i
	end

	def self.get_host_without_www(url) # Return Host name of URL
	  uri = URI.parse(url)
	  uri = URI.parse("http://#{url}") if uri.scheme.nil?
	  host = uri.host.downcase
	  host.start_with?('www.') ? host[4..-1] : host
	end

end
