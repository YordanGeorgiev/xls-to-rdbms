use strict ; use warnings ; 

use FindBin;
BEGIN { unshift @INC, "$FindBin::Bin/../lib" }

use Test::More tests => 3 ; 
use Data::Printer ; 

use XlsToRdbms::App::Utils::Initiator ; 
use XlsToRdbms::App::Utils::Logger ; 
use XlsToRdbms::App::Controller::FileIOController ; 

my $objInitiator 				= 'XlsToRdbms::App::Utils::Initiator'->new();	
my $appConfig					= {} ;
my $ProductBaseDir 			= $objInitiator->doResolveMyProductBaseDir();
my $ProductDir 				= $objInitiator->doResolveMyProductDir();
my $ProductInstanceDir 		= $objInitiator->doResolveMyProductInstanceDir();
my $EnvironmentName 			= $objInitiator->doResolveMyEnvironmentName();
my $ProductName 				= $objInitiator->doResolveMyProductName();
my $ProductVersion 			= $objInitiator->doResolveMyProductVersion();
my $ProductType 				= $objInitiator->doResolveMyProductType();
my $ProductOwner 				= $objInitiator->doResolveMyProductOwner();
my $ConfFile 					= $objInitiator->doResolveMyConfFile();
my $HostName					= $objInitiator->doResolveMyHostName();

$appConfig						= $objInitiator->get ('AppConfig'); 
my $objLogger					= 'XlsToRdbms::App::Utils::Logger'->new(\$appConfig);

my $LogFile						= $objLogger->get('LogFile') ; 
my $test_counter				= 1 ; 
my $input_file            = $ProductInstanceDir . "/non/existent/file.txt" ; 
my $ret                    = 0 ; 
my $msg                    = {} ; 

my $objFileIOController = 
   'XlsToRdbms::App::Controller::FileIOController'->new ( \$appConfig ) ; 

isa_ok($objFileIOController, "XlsToRdbms::App::Controller::FileIOController");
$test_counter++ ; 

can_ok($objFileIOController, $_) for qw(doLoadIssuesFileToDb);
$test_counter++ ; 

( $ret , $msg )            = $objFileIOController->doLoadIssuesFileToDb ( $input_file ) ; 

ok ( $ret eq 1 ) 

# test that the return code is 1 if a non-existign isssue file is passed
