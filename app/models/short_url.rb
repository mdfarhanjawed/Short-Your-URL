class ShortUrl < ApplicationRecord
	validates_uniqueness_of :short_url

	ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
	  # make your own alphabet using:	  

	def self.bijective_encode(i)	  
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

	def self.bijective_decode(s)
	  # converting from string to number for identification	  
	  i = 0
	  base = ALPHABET.length
	  s.each_char { |c| i = i * base + ALPHABET.index(c) }
	  i
	end

	def self.get_host_without_www(url)
	  uri = URI.parse(url)
	  uri = URI.parse("http://#{url}") if uri.scheme.nil?
	  host = uri.host.downcase
	  host.start_with?('www.') ? host[4..-1] : host
	end

end
