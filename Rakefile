require 'kitchen/rake_tasks'

namespace "windows_ad_pair" do
  Dir.chdir File.dirname(__FILE__) do
    Kitchen::RakeTasks.new
  end
  
  desc "run integration tests"
  task :integration do
    system('kitchen destroy')
    system('kitchen converge primary-windows-2012R2')
    system("kitchen exec primary-windows-2012R2 -c 'Restart-Computer -Force'")
    system('kitchen converge backup-windows-2012R2')
    system("kitchen exec backup-windows-2012R2 -c 'Restart-Computer -Force'")
    system('kitchen verify primary-windows-2012R2')
    system('kitchen verify backup-windows-2012R2')
  end
end