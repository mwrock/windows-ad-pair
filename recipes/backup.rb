primary = search_for_nodes("run_list:*windows_ad_pair??primary*")
primary_ip = primary[0]['ipaddress']

powershell_script 'setting primary dns server to primary ad' do
  code <<-EOS
    Get-NetAdapter | Set-DnsClientServerAddress -ServerAddresses '#{primary_ip}'
  EOS

  guard_interpreter :powershell_script
  not_if "(Get-NetAdapter | Get-DnsClientServerAddress -AddressFamily IPv4).ServerAddresseses -contains '#{primary_ip}'"
end

node.default['windows_ad_pair']['domain_type'] = 'replica'
include_recipe 'windows_ad_pair::default'