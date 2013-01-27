require 'rubygems'
require 'github_api'

handle = File.new("/dev/tty")
print "what is thine password: "
password = handle.gets
handle.close

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
