#!/usr/bin/env perl

use strict;
use warnings;

   $|++;


require Exporter ;
our @ISA = qw(Exporter);
our %EXPORT_TAGS = ( 'all' => [ qw() ] );
our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
our @EXPORT = qw() ;
our $AUTOLOAD =();

use utf8 ;
use Data::Printer ; 
use Carp ;
use Cwd qw ( abs_path ) ;
use Getopt::Long;


   BEGIN {
      use Cwd qw (abs_path) ;
      my $my_inc_path = Cwd::abs_path( $0 );

      $my_inc_path =~ m/^(.*)(\\|\/)(.*?)(\\|\/)(.*)/;
      $my_inc_path = $1;
      
      # debug ok print "\$my_inc_path $my_inc_path \n" ; 

      unless (grep {$_ eq "$my_inc_path"} @INC) {
         push ( @INC , "$my_inc_path" );
         $ENV{'PERL5LIB'} .= "$my_inc_path" ;
      }

      unless (grep {$_ eq "$my_inc_path/lib" } @INC) {
         push ( @INC , "$my_inc_path/lib" );
         $ENV{'PERL5LIB'} .= ":$my_inc_path/lib" ;
      }
   }

# use own modules ...
use XlsToRdbms::App::Utils::Initiator ; 
use XlsToRdbms::App::Utils::Configurator ; 
use XlsToRdbms::App::Utils::Logger ; 
use XlsToRdbms::App::Utils::IO::FileHandler ; 
use XlsToRdbms::App::Controller::ControllerXlsToRdbms ; 

my $module_trace                 = 1 ; 
my $md_file 							= '' ; 
my $rdbms_type 						= 'postgre' ; #todo: parametrize to 
my $xls_file                     = '' ; 
my $objInitiator                 = {} ; 
my $appConfig                    = {} ; 
my $objLogger                    = {} ; 
my $objFileHandler               = {} ; 
my $msg                          = q{} ; 
my $objConfigurator              = {} ; 
my $actions                      = q{} ; 
my $tables_list                  = q{} ; 
my $db_name                      = q{} ; 
   #
   # the main shell entry point of the application
   #
   sub main {
      
      my $msg     = '' ; 
      my $ret     = 1 ; 
    
      print " xls_to_rdbms.pl START  \n " ; 
      doInitialize();	

      $actions = 'file-to-db' unless ( $actions )  ; 

      my @actions = split /,/ , $actions ; 
     
      foreach my $action ( @actions ) { 
         $msg = "running the $action action " ; 
         $objLogger->doLogInfoMsg ( $msg ) ; 

         if ( $action eq 'xls-to-db' ) {
            $msg = 'xls_file to parse : ' . "\n" . $xls_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 
            my $objControllerXlsToRdbms = 
               'XlsToRdbms::App::Controller::ControllerXlsToRdbms'->new ( \$appConfig ) ; 
            ( $ret , $msg ) = $objControllerXlsToRdbms->doReadXlsFileToHashRefs2 ( $xls_file ) ; 
            ( $ret , $msg ) = $objControllerXlsToRdbms->doInsertDbTables ( ) ; 
         } 
         elsif ( $action eq 'db-to-xls' ) {
            $msg = 'xls_file to parse : ' . "\n" . $xls_file ; 
            $objLogger->doLogInfoMsg ( "$msg" ) ; 
         } 
         else {
            $msg = "unknown $action action !!!" ; 
            $objLogger->doLogErrorMsg ( $msg ) ; 
         }
         

      } 
      #eof foreach action 

      doExit ( $ret , $msg ) ; 

   }
   #eof sub main



   sub doInitialize {

      $objInitiator 		= 'XlsToRdbms::App::Utils::Initiator'->new();
      $appConfig 			= $objInitiator->get('AppConfig') ; 
      p ( $appConfig  ) if $module_trace == 1 ; 

      $objConfigurator 	= 
         'XlsToRdbms::App::Utils::Configurator'->new( $objInitiator->{'ConfFile'} , \$appConfig ) ; 
      $objLogger 			= 'XlsToRdbms::App::Utils::Logger'->new( \$appConfig ) ;
         
      $objLogger->doLogInfoMsg ( "START MAIN") ; 
      $objLogger->doLogInfoMsg ( "START LOGGING SETTINGS ") ; 


      GetOptions(	
           'xls-file=s'       => \$xls_file
         , 'do=s'             => \$actions
         , 'db_name=s'        => \$db_name
         , 'tables=s'         => \$tables_list
      );
      
      $appConfig->{ 'xls_file' } = $xls_file ; 
      $appConfig->{ 'tables_list' } = $tables_list ; 
      $appConfig->{ 'db_name' } = $db_name if ( $db_name ) ; 

      p ( $appConfig  ) ; 
      $objLogger->doLogInfoMsg ( "STOP  LOGGING SETTINGS ") ; 
   } 
   #eof sub doInitialize


   #
   # pass the exit msg and the exit to the calling process
   #
   sub doExit {

      my $exit_code  = shift ;
      my $exit_msg   = shift || 'exit xls_to_rdbms.pl' ;

      if ( $exit_code == 0 ) {
         $objLogger->doLogInfoMsg ( $exit_msg ) ;
      } else {
         $objLogger->doLogErrorMsg ( $exit_msg ) ;
         $objLogger->doLogFatalMsg ( $exit_msg ) ;
      }

      my $msg = "STOP MAIN for $0" ;
      $objLogger->doLogInfoMsg ( $msg ) ;
      exit ( $exit_code ) ;
   }


# Action !!!
main () ; 

