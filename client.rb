#!/usr/bin/ruby

require 'rest-client'
url=ARGV[0]
video=ARGV[1]
puts "Asking server at #{url} to encode #{video}\n"

response = RestClient::Resource.new("#{url}/encode", :read_timeout => 1800)

begin
  response.post  :media => File.new(video, 'rb'), :size => "720x480", :container => "mp4", :vcodec => "libx264", :vbitrate => "512", :acodec => "aac", :abitrate => "128"
rescue Errno::EPIPE
  puts "Connection broke!  Retrying..."
  response.post  :media => File.new(video, 'rb'), :size => "720x480", :container => "mp4", :vcodec => "libx264", :vbitrate => "512", :acodec => "aac", :abitrate => "128"
end

File.open("media/#{video}", "w") do |f|
  f.write(response.body)
end

