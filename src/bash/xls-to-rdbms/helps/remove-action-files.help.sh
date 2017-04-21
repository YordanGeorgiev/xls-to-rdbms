# src/bash/xls-to-rdbms/funcs/remove-action-files.help.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doHelpRemoveActionFiles comments ...
# ---------------------------------------------------------
doHelpRemoveActionFiles(){

	doLog "DEBUG START doHelpRemoveActionFiles"
	
	cat doc/txt/xls-to-rdbms/helps/remove-action-files.help.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doHelpRemoveActionFiles"
}
# eof func doHelpRemoveActionFiles


# eof file: src/bash/xls-to-rdbms/funcs/remove-action-files.help.sh
