# src/bash/xls-to-rdbms/funcs/run-perl-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doRunPerlTests comments ...
# ---------------------------------------------------------
doRunPerlTests(){
	
	doLog "DEBUG START : doRunPerlTests"

	doLog "INFO Component testing Initiator.pm with TestInitiator "
	perl src/perl/xls_to_rdbms/t/TestInitiator.pm
	test -z "$sleep_iterval" || sleep $sleep_iterval
	
	doLog "INFO Component testing Logger.pm with TestLogger "
	perl src/perl/xls_to_rdbms/t/TestLogger.pl
	test -z "$sleep_iterval" || sleep $sleep_iterval
	
	doLog "INFO Component testing Logger.pm with TestLogger "
	perl src/perl/xls_to_rdbms/t/TestControllerXlsToRdbms.pl
	test -z "$sleep_iterval" || sleep $sleep_iterval
	doLog "INFO STOP  : doRunPerlTests"
}
# eof func doRunPerlTests


# eof file: src/bash/xls-to-rdbms/funcs/run-perl-tests.func.sh
