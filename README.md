chef-handler-zenoss
===================

Chef Report/Exception Handler that uses the Zenoss JSON API to insert Events.

```ruby
chef_handler "ZaaS::ZenossJSONAPI" do
  source "#{node['chef_handler']['handler_path']}/zaas_handler.rb"
  arguments ['ip_or_dns_of_zenoss', 'username_with_privs', 'password']
  action :enable
end
```

```ruby
def initialize(ip_addr, user, pass, protocol='https://', device='ChefDeploy', component='ChefHandler')
```