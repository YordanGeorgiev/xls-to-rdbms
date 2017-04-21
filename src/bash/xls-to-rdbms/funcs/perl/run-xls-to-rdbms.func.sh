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
   # input_file="/vagrant/futu/futu-care/futu-care.1.0.1.prd.ysg/docs/txt/daily/""$nice_year""/""$nice_date"".daily-issues.ygeo.txt"
   # input_file='/vagrant/ysg/data/scrum/daily/'"$nice_year"'/'"$nice_date"'.daily-issues.ysg.txt'
   # input_file='/vagrant/futu/telia/doc/txt/'"$nice_year"'/'"$nice_date"'.futu-telia-issues.txt'
   # input_file='/vagrant/futu/telia/doc/txt/'"$nice_year"'/telia-issues.'"$nice_date"'.txt'
   # input_file='/vagrant/futu/futu-here/doc/here.issues.'"$nice_date"'.sh'
   input_file='/vagrant/futu/telia/doc/txt/2017/2017-04/2017-04-18/telia-first-meeting-notes.2017-04-18.txt'	
   # Action ... !!!
   perl src/perl/xls_to_rdbms/script/xls_to_rdbms.pl --do file-to-db --input_file $input_file
   exit_code=$?
   doLog "INFO doRunXlsToRdbms exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run xls_to_rdbms.pl"  
   
   # Action ... !!!
   perl src/perl/xls_to_rdbms/script/xls_to_rdbms.pl --do db-to-xls --input_file $input_file
   exit_code=$?
   doLog "INFO doRunXlsToRdbms exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run xls_to_rdbms.pl"  
#
	doLog "DEBUG STOP  doRunXlsToRdbms"
}
# eof func doRunXlsToRdbms


# eof file: src/bash/xls-to-rdbms/funcs/run-xls-to-rdbms.func.sh
