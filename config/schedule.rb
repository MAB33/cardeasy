set :environment, "development"
set :output, {:error => "log/cron_error_log.log", :standard => "log/cron_log.log"}

every 1.day, :at => '12:01am' do
  rake "simplysent:collect_cards"
end
