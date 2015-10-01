#!/usr/bin/ruby

require 'rest-client'
url=ARGV[0]
video=ARGV[1]
print "Asking server at #{url} to encode #{video}\n"

response = RestClient.post "#{url}/encode", :media => File.new(video, 'rb'), :size => "720x480", :container => "mp4", :vcodec => "libx264", :vbitrate => "512", :acodec => "aac", :abitrate => "128"
File.open("media/#{video}", "w") do |f|
  f.write(response.body)
end

