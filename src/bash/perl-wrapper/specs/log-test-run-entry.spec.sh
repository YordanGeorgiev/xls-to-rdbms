# src/bash/xls-to-rdbms/funcs/log-test-run-entry.spec.sh

# v1.0.0
# ---------------------------------------------------------
# todo: add doSpecLogTestRunEntry comments ...
# ---------------------------------------------------------
doSpecLogTestRunEntry(){

	doLog "DEBUG START doSpecLogTestRunEntry"
	
	cat doc/txt/xls-to-rdbms/specs/log-test-run-entry.spec.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doSpecLogTestRunEntry"
}
# eof func doSpecLogTestRunEntry


# eof file: src/bash/xls-to-rdbms/funcs/log-test-run-entry.spec.sh
