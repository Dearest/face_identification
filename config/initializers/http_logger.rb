worker_logfile = File.open("#{Rails.root}/log/http.log", 'a')
worker_logfile.sync = true
HTTP_LOGGER = HttpLogger.new(worker_logfile)