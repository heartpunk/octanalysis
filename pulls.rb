require 'rubygems'
require 'github_api'

puts "what is thine password: "
password = gets
github = Github.new :login => ARGV[0], :password => password

pulls = []
pull_types = ['open', 'closed']

pull_types.each do |pull_type|
  tmp = github.pull_requests.list 'rails', 'rails', {:state => pull_type, :per_page => 100}
  tmp.each_page do |page|
    page.each do |pull|
      pulls << pull
    end
  end
end
