package XlsToRdbms::App::Model::PostGreDbHandler ; 

   use strict ; use warnings ; use utf8 ; 

   require Exporter; 
   use AutoLoader ; 
	use Encode qw( encode_utf8 is_utf8 );
   use POSIX qw(strftime);
   use DBI ; 
   use DBD::Pg ; 
	use Data::Printer ; 
	use Carp ; 

   use XlsToRdbms::App::Utils::Logger ; 

   our $module_trace                            = 1 ; 
   our $IsUnitTest                              = 0 ; 
	our $appConfig 										= q{} ; 
	our $objLogger 										= q{} ; 

	our $db_name                                 = q{} ; 
	our $db_host 										   = q{} ; 
	our $db_port 										   = q{} ;
	our $db_user 											= q{} ; 
	our $db_user_pw	 									= q{} ; 
	our $web_host 											= q{} ; 


	#
   # ------------------------------------------------------
	#  input: hash ref of hash refs containing the issues 
	#  file data  and meta data 
   # ------------------------------------------------------
	sub doHsr2ToDb {

		my $self 				= shift ; 
		my $hsr2 			   = shift ; 	# the hash ref of hash refs  aka hs r on power 2
      
      my $ret              = 1 ; 
      my $msg              = 'unknown error while sql insert ' ; 		
      my $str_sql_insert   = q{} ; 
      my $str_col_list     = q{} ; 
      my $str_val_list     = q{} ; 
      my $error_msg        = q{} ; 


      my $debug_msg        = 'START doInsertSqlHashData' ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
	  
 
		foreach my $key ( sort(keys( %{$hsr2} ) ) ) {
         my $row_hash = $hsr2->{ $key } ; 

		   foreach my $key ( sort(keys( %{$row_hash} ) ) ) {
            $str_col_list .= ' , ' . $key ; 
            my $value     = $row_hash->{ $key } || 'null' ; 
            $value =~ s|\\|\\\\|g ;
            $value       =~ s|\'|\\\'|g ;
            $str_val_list .= ' , \'' . $value . '\''; 
         }
         
         $str_col_list = substr ( $str_col_list , 3 ) ; 
         $str_val_list = substr ( $str_val_list , 3 ) ; 

         $str_sql_insert .= 'INSERT INTO issue ' ; 
         $str_sql_insert .= '( ' . $str_col_list . ') VALUES (' . $str_val_list . ');' . "\n" ; 

         $str_col_list = '' ; 
         $str_val_list = '' ; 
      }
      
      p ( $str_sql_insert ) if $module_trace == 1 ; 

      # proper authentication implementation src:
      # http://stackoverflow.com/a/19980156/65706
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
     
      my $dbh = DBI->connect("DBI:Pg:dbname=$db_name", "", "" , {
           'RaiseError' => 1
         , 'ShowErrorStatement' => 1
         , 'AutoCommit' => 1
      } ) or $msg = DBI->errstr;
      
      
      $ret = $dbh->do( $str_sql_insert ) ; 
      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'INSERT OK' ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES

      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg ) ; 	
	}
	#eof sub doHsr2ToDb


	#
	# -----------------------------------------------------------------------------
	# runs the insert sql by passed data part 
	# by convention is assumed that the first column is unique and update could 
	# be performed on it ... should there be duplicates the update should fail
	# -----------------------------------------------------------------------------
	sub doInsertDbTablesWithHsr2 {

		my $self 			   = shift ; 
		my $hsr2 		      = shift ; 
		my $ret 				   = 1 ; 
		my $msg 				   = ' failed to connect during insert to db !!! ' ; 
		my $debug_msg 		   = ' failed to connect during insert to db !!! ' ; 
      my $sth              = {} ;    # this is the statement handle
      my $dbh              = {} ;    # this is the database handle
      my $str_sql          = q{} ;   # this is the sql string to use for the query
      my $rv               = 0 ;     # apperantly insert ok returns rv = 1 !!! 

      # obs this does not support ordered primary key tables first order yet !!!
      foreach my $table_name ( keys %$hsr2 ) { 
         my $hs_table = $hsr2->{ $table_name } ; 
         my $hs_headers = $hsr2->{ $table_name }->{ 0 } ; 		   
     
         eval { 
            $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
                 'RaiseError'          => 1
               , 'ShowErrorStatement'  => 1
               , 'AutoCommit'          => 1
            } ); 
         } or $ret = 2  ;
         
         if ( $ret == 2 ) {
            $msg = DBI->errstr;
            $objLogger->doLogErrorMsg ( $msg ) ; 
            return ( $ret , $msg ) ; 
         } else {
            $msg = 'connect OK' ; 
            $objLogger->doLogDebugMsg ( $msg ) ; 
         }

         my $sql_str          = '' ; 
         my $sql_str_insrt    = " INSERT INTO $table_name " ; 
         $sql_str_insrt      .= '(' ; 

         foreach my $col_num ( sort ( keys %$hs_headers )) {
            my $column_name = $hs_headers->{ $col_num } ; 
            $sql_str_insrt .= " $column_name " . ' , ' ; 
         } 
         
         for (1..3) { chop ( $sql_str_insrt) } ; 
         $sql_str_insrt	.= ')' ; 

         foreach my $row_num ( sort ( keys %$hs_table ) ) { 

            next if $row_num == 0 ; 
            my $hs_row = $hs_table->{ $row_num } ; 
            my $data_str = q{} ; 

            foreach my $col_num ( sort ( keys ( %$hs_row ) ) ) {
               my $cell_value = $hs_row -> { $col_num } ; 
               $cell_value = '' unless ( defined ( $cell_value )) ; 
               $cell_value =~ s|\\|\\\\|g ; 
               # replace the ' chars with \'
               $cell_value 		=~ s|\'|\'\'|g ; 
               $data_str .= "'" . "$cell_value" . "' , " ; 
            }
            #eof foreach col_num
            
            # remove the " , " at the end 
            for (1..3) { chop ( $data_str ) } ; 
            
            $sql_str .= $sql_str_insrt ;  
            $sql_str	.=  " VALUES (" . "$data_str" . ') ; ' . "\n" ; 

            # $objLogger->doLogDebugMsg ( "sql_str : $sql_str " ) ; 

         } 
         #eof foreach row

         # Action !!! 
         eval { 
            $rv = $dbh->do($sql_str) ; 
         } or $msg = $@ ; 

         unless ( $rv == 1 ) { 
            $msg .= " DBI upsert error on table: $table_name: " . $msg  ; 
            $objLogger->doLogFatalMsg ( $msg ) ;   ; 
            return ( $ret , $msg ) ; # all or nothing ok 
         } 
         else {  
            $msg = "upsert OK for table $table_name" ;          
            $objLogger->doLogInfoMsg ( $msg ) ; 
         }

      } 
      #eof foreach table_name
		
      $ret = 0 ; $msg = 'upsert OK for all tables' ; 
		return ( $ret , $msg ) ; 
	}
	#eof sub doRunUpsertSql


   #
   # -----------------------------------------------------------------------------
   # get ALL the table data into hash ref of hash refs 
   # -----------------------------------------------------------------------------
   sub doSelectTableIntoHashRef {

      my $self             = shift ; 
      my $table            = shift ;      # the table to get the data from  
      
      my $msg              = q{} ;         
      my $debug_msg        = q{} ;         
      my $ret              = 1 ;          # this is the return value from this method 
      my $hsr              = {} ;         # this is hash ref of hash refs to populate with
      my $mhsr             = {} ;         # this is meta hash describing the data hash ^^
      my $sth              = {} ;         # this is the statement handle
      my $dbh              = {} ;         # this is the database handle
      my $str_sql          = q{} ;        # this is the sql string to use for the query

      $str_sql = 
         " SELECT 
         * FROM $table ;
      " ; 

      # authentication src: http://stackoverflow.com/a/19980156/65706
      $dbh = DBI->connect("dbi:Pg:dbname=$db_name", "", "" , {
           'RaiseError' => 1
         , 'ShowErrorStatement' => 1
         , 'AutoCommit' => 1
      } ) or $msg = DBI->errstr;
      
      # src: http://www.easysoft.com/developer/languages/perl/dbd_odbc_tutorial_part_2.html
      $sth = $dbh->prepare($str_sql);  

      $sth->execute()
            or $objLogger->error ( "$DBI::errstr" ) ;

      $hsr = $sth->fetchall_hashref( 'issue_id' ) ; 
      binmode(STDOUT, ':utf8');
      p( $hsr ) if $module_trace == 1 ; 

      $msg = DBI->errstr ; 

      unless ( defined ( $msg ) ) {
         $msg = 'SELECT OK for table: ' . "$table" ; 
         $ret = 0 ; 
      } else {
         $objLogger->doLogErrorMsg ( $msg ) ; 
      }

      # src: http://search.cpan.org/~rudy/DBD-Pg/Pg.pm  , METHODS COMMON TO ALL HANDLES
      $debug_msg        = 'doInsertSqlHashData ret ' . $ret ; 
      $objLogger->doLogDebugMsg ( $debug_msg ) ; 
      
      return ( $ret , $msg , $hsr , $mhsr ) ; 	
   }
   # eof sub doSelectTableIntoHashRef



   #
   # -----------------------------------------------------------------------------
   # doInitialize the object with the minimum dat it will need to operate 
   # -----------------------------------------------------------------------------
   sub doInitialize {
      
      my $self          = shift ; 
		my $appConfig     = ${ shift @_ } if ( @_ );

		#debug print "PostGreDbHandler::doInitialize appConfig : " . p($appConfig );
		
		$db_name 			= $appConfig->{'db_name'} 		|| 'prd_pgsql_runner' ; 
		$db_host 			= $appConfig->{'db_host'} 		|| 'localhost' ;
		$db_port 			= $appConfig->{'db_port'} 		|| '13306' ; 
		$db_user 			= $appConfig->{'db_user'} 		|| 'ysg' ; 
		$db_user_pw 		= $appConfig->{'db_user_pw'} 	|| 'no_pass_provided!!!' ; 
      
	   $objLogger 			= 'XlsToRdbms::App::Utils::Logger'->new( \$appConfig ) ;
   }
   #eof sub doInitialize

	
   #
   # -----------------------------------------------------------------------------
   # the constructor 
   # source:http://www.netalive.org/tinkering/serious-perl/#oop_constructors
   # -----------------------------------------------------------------------------
   sub new {

      my $class            = shift ;    # Class name is in the first parameter
		$appConfig           = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize( \$appConfig ) ; 
      return $self;
   } 
   #eof const 
   


1;


__END__
