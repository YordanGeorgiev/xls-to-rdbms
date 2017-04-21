#!/bin/bash 

#v1.1.0
#------------------------------------------------------------------------------
# tests the full package creation
#------------------------------------------------------------------------------
doTestCreateFullPackage(){
	cd $product_instance_dir
	doLog " INFO START : create-full-package.test"
	
	cat doc/txt/xls-to-rdbms/tests/pckg/create-full-package.test.txt

	doSpecCreateFullPackage

	doHelpCreateFullPackage

   export exit_code=0
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a create-full-package
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a create-full-package -i $product_instance_dir/met/.tst.xls-to-rdbms
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a create-full-package -i $product_instance_dir/met/.prd.xls-to-rdbms
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	
	bash src/bash/xls-to-rdbms/xls-to-rdbms.sh -a create-full-package -i $product_instance_dir/met/.git.xls-to-rdbms
   export exit_code=$?
	doLog " create-relative-package.test-1 exit_code: $exit_code "
   test -z "$sleep_interval" || sleep "$sleep_interval"
   test $exit_code -ne 0 && return
	

	doLog " INFO STOP  : create-full-package.test"
}
#eof test doCreateFullPackage
