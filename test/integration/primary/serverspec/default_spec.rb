require 'serverspec'
set :backend, :cmd
set :os, :family => 'windows'

describe windows_feature('AD-Domain-Services') do
  it{ should be_installed.by("powershell") }
end

describe windows_feature('DNS') do
  it{ should be_installed.by("powershell") }
end

# Is it a primary domain controller; needs to equal 5 (backup = 4)
describe command('(Get-WmiObject Win32_ComputerSystem).DomainRole') do
  its(:stdout) { should eq "5\n" }
end

describe command('(Get-WmiObject Win32_ComputerSystem).Domain') do
  its(:stdout) { should eq "kitchen.local\n" }
end
