#!/usr/bin/ruby
require 'Net/HTTP'
require 'json'
uri = URI('http://77.232.128.205:3003/masscreate/')
req = Net::HTTP::Post.new(uri, 'Content-Type' => 'application/json')
ipsh=[]
100.times do
  ip = [rand(255),rand(255),rand(255),rand(255)].join(".")
  ipsh.push({ip: ip})
end

req.body = ipsh.to_json
res = Net::HTTP.start(uri.hostname, uri.port) do |http|
  http.request(req)
end