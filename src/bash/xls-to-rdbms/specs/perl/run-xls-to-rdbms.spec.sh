# src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecRunXlsToRdbms comments ...
# ---------------------------------------------------------
doSpecRunXlsToRdbms(){

	doLog "DEBUG START doSpecRunXlsToRdbms"
	
	cat doc/txt/xls-to-rdbms/specs/perl/run-xls-to-rdbms.spec.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doSpecRunXlsToRdbms"
}
# eof func doSpecRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.spec.sh
