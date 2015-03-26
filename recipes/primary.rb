node.default['windows_ad_pair']['domain_type'] = 'forest'

include_recipe 'windows_ad_pair::default'

windows_ad_user node["windows_ad_pair"]["administrator_user"] do
  action :create
  domain_name node["windows_ad_pair"]["fqdn"]
  ou "Users"
  options ({
   "disabled" => "no",
   "pwd" => node["windows_ad_pair"]["administrator_password"]
  })
end

windows_ad_group_member node["windows_ad_pair"]["administrator_user"] do
  action :add
  group_name  'Domain Admins'
  group_ou 'Users'
  user_ou 'Users'
  domain_name node["windows_ad_pair"]["fqdn"]
end
