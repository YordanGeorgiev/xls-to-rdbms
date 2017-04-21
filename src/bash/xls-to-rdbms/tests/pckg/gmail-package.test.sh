# src/bash/xls-to-rdbms/funcs/gmail-package.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestGmailPackage comments ...
# ---------------------------------------------------------
doTestGmailPackage(){

	doLog "DEBUG START doTestGmailPackage"
	
   cat doc/txt/xls-to-rdbms/tests/pckg/gmail-package.test.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"

	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a create-full-package -a gmail-package
	test -z "$sleep_interval" || sleep "$sleep_interval"
   printf "\033[2J";printf "\033[0;0H"

	doLog "DEBUG STOP  doTestGmailPackage"
}
# eof func doTestGmailPackage


# eof file: src/bash/xls-to-rdbms/funcs/gmail-package.test.sh
