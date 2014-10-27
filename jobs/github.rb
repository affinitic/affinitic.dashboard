require 'github_api'

myfile = File.open('pass/pwdgithub.json', 'r')
myinfo = JSON.parse(myfile.read)

connection = Github.new :oauth_token => myinfo['token'] 
pulls=0
issuesCount=0
issues = connection.issues.list(:org => 'affinitic', :filter => 'all', :auto_pagination => true)
issues.each do |issue|
  if issue["pull_request"]
    pulls += 1
  else
    issuesCount+=1
  end
end


SCHEDULER.every '100s', :first_in => 0 do
  send_event('github_feed', pulls:pulls, issues:issuesCount,
             pulls_redirect: "https://github.com/pulls?user=affinitic",
             issues_redirect: "https://github.com/issues?user=affinitic")
end


