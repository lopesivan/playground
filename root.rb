user_name = user['name']
ssh_key   = user['ssh_key']
home      = "/#{user_name}"

# Create .ssh directory
directory "#{home}/.ssh" do
  owner user_name
  group user_name
end

# create an authorized_keys file
authorized_keys_file ="#{home}/.ssh/authorized_keys"
file authorized_keys_file do
  owner user_name
  mode  0600
  content "#{ssh_key} #{user_name}"
  not_if { ::File.exists?("#{authorized_keys_file}")}
end
