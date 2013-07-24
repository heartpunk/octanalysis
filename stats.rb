require 'json'
require 'pp'
require 'date'

File.open('./pulls.json') do |f|
  pulls = JSON.parse(f.read)
  open = pulls.select {|p| p['state'] == 'open'}
  dates = open.map {|p| Date.parse(p['created_at'])}.map {|d| [d.year, d.month]}
  puts "months"
  pp dates.group_by {|f| f}.values.map {|v| [v[0],v.size]}.sort
  puts "users"
  users = pulls.select {|p| p['user']}.map {|p| p['user']['login']}
  pp users.group_by {|u| u}.values.map {|v| [v.size, v[0]]}.sort_by {|a| a[0]}
  # pp pulls.group_by {|p| p['user']['login']}.values.map {|v| [v[0], v.size]}
end