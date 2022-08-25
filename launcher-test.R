# Run as a Launcher Job
logr::log_open('launcher.log')
Sys.sleep(30)
logr::log_print('thirty seconds have passed')
Sys.sleep(30)
logr::log_print('one minute has passed')
logr::log_close()
