# src/bash/xls-to-rdbms/funcs/check-perl-syntax.spec.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doSpecCheckPerlSyntax comments ...
# ---------------------------------------------------------
doSpecCheckPerlSyntax(){

	doLog "DEBUG START doSpecCheckPerlSyntax"
	
	cat doc/txt/xls-to-rdbms/specs/check-perl-syntax.spec.txt
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 

	doLog "DEBUG STOP  doSpecCheckPerlSyntax"
}
# eof func doSpecCheckPerlSyntax


# eof file: src/bash/xls-to-rdbms/funcs/check-perl-syntax.spec.sh
