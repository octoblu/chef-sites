script "npm install npm" do
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-EOH
    npm install -g npm
  EOH
end

node[:deploy].each do |application, deploy|
  script "npm install" do
    interpreter "bash"
    user "root"
    cwd "/tmp"
    code <<-EOH
      sudo su - #{deploy[:user]} -c 'if [ -f #{deploy[:deploy_to]}/current ]; then ln -s #{deploy[:deploy_to]}/shared/node_modules #{deploy[:deploy_to]}/current; cd #{deploy[:deploy_to]}/current && npm install --dev; fi' 2>&1
    EOH
  end
end

