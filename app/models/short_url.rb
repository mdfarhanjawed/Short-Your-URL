class ShortUrl < ApplicationRecord


	ALPHABET = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".split(//)
	  # make your own alphabet using:
	  # (('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a).shuffle.join

	def self.bijective_encode(i)
	  # from http://refactormycode.com/codes/125-base-62-encoding
	  # with only minor modification
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
	  # based on base2dec() in Tcl translation 
	  # at http://rosettacode.org/wiki/Non-decimal_radices/Convert#Ruby
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
