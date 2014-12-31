def create_deployers(data)

  user_name = data["name"]
  ssh_key   = data["ssh-key"]
  home      = "/home/#{user_name}"

  # Create a User [deploy]
  user user_name do
    home  home
    shell "/bin/bash"
    supports :manage_home => true # Manage home directory
  end

  # Add [deploy] to [wheel]group
  group "deployers" do
    action [:create]
    members [user_name]
    append true
  end

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

end

secret = Chef::EncryptedDataBagItem.load_secret("/.chef/encrypted_data_bag_secret")

node.deployers.names.each do |current_user|
  data = Chef::EncryptedDataBagItem.load("deployers", "#{current_user}", secret)
  create_deployers(data)
end

