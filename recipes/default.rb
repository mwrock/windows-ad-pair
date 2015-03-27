include_recipe 'windows_ad::default'

options = node['windows_ad_pair']['options'] || {}
type    = node['windows_ad_pair']['domain_type']
domain  = node["windows_ad_pair"]["fqdn"]

windows_ad_domain domain do
  type type
  safe_mode_pass node['windows_ad_pair']['safe_mode_pass']
  if type == "replica"
    domain_user "#{node['windows_ad_pair']['administrator_user']}@#{domain}"
    domain_pass node['windows_ad_pair']['administrator_password']
  end
  options options
  action :create
end
