package XlsToRdbms::App::Controller::ControllerXlsToRdbms ; 

	use strict; use warnings; use utf8 ; 

	my $VERSION = '1.0.0';    

	require Exporter;
	our @ISA = qw(Exporter);
	our $AUTOLOAD =();
	use AutoLoader;
   use Carp ;
   use Data::Printer ; 

   use XlsToRdbms::App::Utils::Logger ; 
   use XlsToRdbms::App::Utils::IO::ExcelHandler ; 
	
	our $module_trace                = 0 ; 
	our $appConfig						   = {} ; 
	our $RunDir 						   = '' ; 
	our $ProductBaseDir 				   = '' ; 
	our $ProductDir 					   = '' ; 
	our $ProductInstanceDir 			= ''; 
	our $ProductInstanceEnvironment  = '' ; 
	our $ProductName 					   = '' ; 
	our $ProductType 					   = '' ; 
	our $ProductVersion 				   = ''; 
	our $ProductOwner 				   = '' ; 
	our $HostName 						   = '' ; 
	our $ConfFile 						   = '' ; 
	our $objLogger						   = {} ; 
   our $rdbms_type                  = 'postgre' ; 

=head1 SYNOPSIS
      my $objControllerXlsToRdbms = 
         'XlsToRdbms::App::Controller::ControllerXlsToRdbms'->new ( \$appConfig ) ; 
      ( $ret , $msg ) = $objControllerXlsToRdbms->doReadXlsFileToHashRefs3 ( $input_file ) ; 
=cut 

=head1 EXPORT

	A list of functions that can be exported.  You can delete this section
	if you don't export anything, such as for a purely object-oriented module.
=cut 

=head1 SUBROUTINES/METHODS

	# -----------------------------------------------------------------------------
	START SUBS 
=cut




   # 
	# -----------------------------------------------------------------------------
   # read the passed issue file , convert it to hash ref of hash refs 
   # and insert the hsr into a db
	# -----------------------------------------------------------------------------
   sub doReadXlsFileToHashRefs3 {

      my $self          = shift ; 
      my $xls_file      = shift ; 
      my $tables_list   = shift ; 

      my $ret = 0; 
      my $msg = 'file read' ; 

      my $hsr3_meta = {} ;      
      $hsr3_meta->{ 0 } = 'db_name' ; 
      my $db_name       = $appConfig->{ 'db_name' } ;  

      # a hash ref of hash refs ( sheet level ) of hash refs ( column level )
      my $hsr3 = {} ;      
      $hsr3->{ $db_name } = {} ; 

      # instantiate the XlsHandler
	   my $objExcelHandler 	   = 'XlsToRdbms::App::Utils::IO::ExcelHandler'->new ( \$appConfig ) ; 
      ( $ret , $msg , $hsr3->{ $db_name } ) = $objExcelHandler->doReadXlsFileToHsr2( $xls_file ) ; 
      # read the xls into hash ref of hash ref

      print 'START doReadXlsFileToHashRefs3' . "\n" ; 
      print 'STOP  doReadXlsFileToHashRefs3' . "\n" ; 
      
      p($hsr3->{ $db_name });
 
      return ( $ret , $msg ) ; 
   } 


	#
	# --------------------------------------------------------
	# intializes this object 
	# --------------------------------------------------------
	sub doInitialize {
	   my $self       = shift ; 	
		$appConfig  = ${ shift @_ } if ( @_ );

	   $objLogger 			= 'XlsToRdbms::App::Utils::Logger'->new( \$appConfig ) ;
	}	
	#eof sub doInitialize
	

=head1 WIP

	
=cut

=head1 SUBROUTINES/METHODS

	STOP  SUBS 
	# -----------------------------------------------------------------------------
=cut


=head2 new
	# -----------------------------------------------------------------------------
	# the constructor
=cut 

	# -----------------------------------------------------------------------------
	# the constructor 
	# -----------------------------------------------------------------------------
	sub new {
      my $class            = shift ;    # Class name is in the first parameter
		$appConfig = ${ shift @_ } if ( @_ );

      # Anonymous hash reference holds instance attributes
      my $self = { }; 
      bless($self, $class);     # Say: $self is a $class

      $self->doInitialize( \$appConfig ) ; 
      return $self;
		
	}  
	#eof const

=head2
	# -----------------------------------------------------------------------------
	# overrided autoloader prints - a run-time error - perldoc AutoLoader
	# -----------------------------------------------------------------------------
=cut
	sub AUTOLOAD {

		my $self = shift;
		no strict 'refs';
		my $name = our $AUTOLOAD;
		*$AUTOLOAD = sub {
			my $msg =
			  "BOOM! BOOM! BOOM! \n RunTime Error !!! \n Undefined Function $name(@_) \n ";
			croak "$self , $msg $!";
		};
		goto &$AUTOLOAD;    # Restart the new routine.
	}   
	# eof sub AUTOLOAD


	# -----------------------------------------------------------------------------
	# return a field's value
	# -----------------------------------------------------------------------------
	sub get {

		my $self = shift;
		my $name = shift;
		croak "\@UrlSniper.pm sub get TRYING to get undefined name" unless $name ;  
		croak "\@UrlSniper.pm sub get TRYING to get undefined value" unless ( $self->{"$name"} ) ; 

		return $self->{ $name };
	}    #eof sub get


	# -----------------------------------------------------------------------------
	# set a field's value
	# -----------------------------------------------------------------------------
	sub set {

		my $self  = shift;
		my $name  = shift;
		my $value = shift;
		$self->{ "$name" } = $value;
	}
	# eof sub set


	# -----------------------------------------------------------------------------
	# return the fields of this obj instance
	# -----------------------------------------------------------------------------
	sub dumpFields {
		my $self      = shift;
		my $strFields = ();
		foreach my $key ( keys %$self ) {
			$strFields .= " $key = $self->{$key} \n ";
		}

		return $strFields;
	}    
	# eof sub dumpFields
		

	# -----------------------------------------------------------------------------
	# wrap any logic here on clean up for this class
	# -----------------------------------------------------------------------------
	sub RunBeforeExit {

		my $self = shift;

		#debug print "%$self RunBeforeExit ! \n";
	}
	#eof sub RunBeforeExit


	# -----------------------------------------------------------------------------
	# called automatically by perl's garbage collector use to know when
	# -----------------------------------------------------------------------------
	sub DESTROY {
		my $self = shift;

		#debug print "the DESTRUCTOR is called  \n" ;
		$self->RunBeforeExit();
		return;
	}   
	#eof sub DESTROY


	# STOP functions
	# =============================================================================

	


1;

__END__

=head1 NAME

UrlSniper 

=head1 SYNOPSIS

use UrlSniper  ; 


=head1 DESCRIPTION
the main purpose is to initiate minimum needed environment for the operation 
of the whole application - man app cnfig hash 

=head2 EXPORT


=head1 SEE ALSO

perldoc perlvars

No mailing list for this module


=head1 AUTHOR

yordan.georgiev@gmail.com

=head1 



=cut 

