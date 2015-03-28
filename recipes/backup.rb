primary = search_for_nodes("run_list:*windows_ad_pair??primary*")
primary_ip = primary[0]['ipaddress']
primary_subnet = primary_ip.split('.')[0..2].join('.')

if primary_ip != "127.0.0.1"
  powershell_script 'setting primary dns server to primary ad' do
    code <<-EOS
      Get-NetIPConfiguration | ? { 
        $_.IPv4Address.IPAddress.StartsWith("#{primary_subnet}") 
        } | Set-DnsClientServerAddress -ServerAddresses '#{primary_ip}'
    EOS

    guard_interpreter :powershell_script
    not_if "(Get-DnsClientServerAddress -AddressFamily IPv4 | ? { $_.ServerAddresseses -contains '#{primary_ip}' }).count -gt 0"
  end
end

node.default['windows_ad_pair']['domain_type'] = 'replica'
include_recipe 'windows_ad_pair::default'