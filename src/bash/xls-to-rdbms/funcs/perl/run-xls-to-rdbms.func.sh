# src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.func.sh

# v1.1.1
# ---------------------------------------------------------
# todo: add doRunXlsToRdbms comments ...
# ---------------------------------------------------------
doRunXlsToRdbms(){

	doLog "DEBUG START doRunXlsToRdbms"
	
	cat doc/txt/xls-to-rdbms/funcs/perl/run-xls-to-rdbms.func.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
   nice_date=$(date "+%Y-%m-%d")
   nice_year=$(date "+%Y-%m")
   xls_file='/vagrant/ysg/data/txt/issues/2017/2017-04/2017-04-25/.170911.xlsx'
   
   # Action ... !!!
   perl src/perl/xls_to_rdbms/script/xls_to_rdbms.pl --do xls-to-db --xls-file $xls_file
   exit_code=$?
   doLog "INFO doRunXlsToRdbms exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run xls_to_rdbms.pl"  
#
	doLog "DEBUG STOP  doRunXlsToRdbms"
}
# eof func doRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.func.sh
