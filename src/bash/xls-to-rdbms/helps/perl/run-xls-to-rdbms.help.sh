# src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRunXlsToRdbms comments ...
# ---------------------------------------------------------
doHelpRunXlsToRdbms(){

	doLog "DEBUG START doHelpRunXlsToRdbms"
	
	cat doc/txt/xls-to-rdbms/helps/perl/run-xls-to-rdbms.help.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doHelpRunXlsToRdbms"
}
# eof func doHelpRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.help.sh
