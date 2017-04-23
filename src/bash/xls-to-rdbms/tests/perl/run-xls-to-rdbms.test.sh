# src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunXlsToRdbms comments ...
# ---------------------------------------------------------
doTestRunXlsToRdbms(){

	doLog "DEBUG START doTestRunXlsToRdbms"
	

	cat doc/txt/xls-to-rdbms/tests/perl/run-xls-to-rdbms.test.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"

   #----- test-1
   doLog "INFO start test-1 should fail on connect error "
   doLog "INFO OBS stop the postgre "
   sudo /etc/init.d/postgresql stop 
	# Action !!!	
   doLog "INFO THIS call should result in connect error: Action !!! "
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a run-xls-to-rdbms
   exit_code=$?
	doLog " run-xls-to-rdbms.test-1 exit_code: $exit_code "

   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 1 && return
   # if the call fails the test is passed !
   test $exit_code -eq 1 && exit_code=0
   doLog "INFO stop  test-1 should fail on connect error "


   #----- test-2
   doLog "INFO start test-2 should succeed if the table exists "
   doLog "INFO OBS restart the postgre "
   sudo /etc/init.d/postgresql restart
   doLog "INFO THIS call should succeed: Action !!!"
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a run-xls-to-rdbms
   exit_code=$?
   doLog "INFO stop  test-2 should succeed if the table exists "

   # you could also check the data as follows - obs hardcoded db
   # echo 'SELECT * FROM  issue ; ' | psql -d dev_ysg_issues

   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
   # if the call fails the test is passed !
	doLog "DEBUG STOP  doTestRunXlsToRdbms"
}
# eof func doTestRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.test.sh
