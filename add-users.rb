
node['users'].each do |current_user|
  deploy_user = current_user['user']
  deploy_group = current_user['group']
  user_pass = current_user['pass']
  deploy_pass = %x[openssl passwd -1 "#{user_pass}"].chomp
  deploy_comment = current_user['comment']

  user_account deploy_user do
    comment deploy_comment
    shell "/bin/bash"
    password deploy_pass
  end

  group deploy_group do
    action :create
    members deploy_user
    append true
  end

end

unless node['sudoers'].empty?

  group "admin" do
	members node['sudoers']
	action :create
  end

  group "sudo" do
	members node['sudoers']
	action :create
  end

end

#user "jetty" do
#  system True
#end

