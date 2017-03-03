desc "Refresh players data from Foos"
task :suso_refresh => :environment do
  puts "Starting refresh"
  SusoRefreshJob.perform_now
  puts "Done"
end

desc "Refresh players data from Foos async -> A persistent queue is required for this to run"
task :suso_refresh_async => :environment do
  puts "Starting refresh async"
  SusoRefreshJob.perform_later
  puts "Done"
end
