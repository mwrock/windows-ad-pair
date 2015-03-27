require 'kitchen/rake_tasks'

namespace "windowd_ad_pair" do
  Dir.chdir File.dirname(__FILE__) do
    Kitchen::RakeTasks.new
  end
  
  desc "run integration tests"
  task :integration do
    begin
      system('kitchen destroy')
      system('kitchen converge primary-windows-2012R2') or throw "failed to converge primary AD controller"
      system("kitchen exec primary-windows-2012R2 -c 'Restart-Computer -Force'") or throw "failed to restart primary AD controller"
      system('kitchen converge backup-windows-2012R2') or throw "failed to converge secondary AD controller"
      system("kitchen exec backup-windows-2012R2 -c 'Restart-Computer -Force'") or throw "failed to restart secondary AD controller"
      system('kitchen verify primary-windows-2012R2') or throw "failed to verify primary AD controller"      
      system('kitchen verify backup-windows-2012R2') or throw "failed to verify secondary AD controller"
    ensure
      system('kitchen destroy')
    end
  end
end