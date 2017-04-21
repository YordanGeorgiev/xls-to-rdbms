# src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunXlsToRdbms comments ...
# ---------------------------------------------------------
doTestRunXlsToRdbms(){

	doLog "DEBUG START doTestRunXlsToRdbms"
	
	cat doc/txt/xls-to-rdbms/tests/perl/run-xls-to-rdbms.test.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"

	# Action !!!	
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a run-xls-to-rdbms
   exit_code=$?
	doLog " run-xls-to-rdbms.test-1 exit_code: $exit_code "

   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestRunXlsToRdbms"

}
# eof func doTestRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.test.sh
