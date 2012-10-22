From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 22 Oct 2012 13:52:28 +0000
Subject: Re: [lm-sensors] non-interactive sensors-detect
Message-Id: <20121022135228.GA7375@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <507BD5C2.8050506@cern.ch>
In-Reply-To: <507BD5C2.8050506@cern.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 22, 2012 at 02:47:55PM +0200, Jean Delvare wrote:
> On Mon, 15 Oct 2012 12:22:10 +0300, Adrian Sevcenco wrote:
> > Hi! Is there a way to run sensors-detect in a non-interactive way?
> > I try to enable lm_sensors on a cluster and i find no way to do it..
> > Is is possible to add switches like -y (yes all) or -d (default all) to 
> > sensors detect?
> 
> Proposal below. It doesn't feel too safe as random I2C adapters may
> still get probed. But it's definitely better that people trying to get
> a non-interactive sensors-detect using "yes |".
> 
> sensors-detect: Introduce automatic mode
> 
> Add option --auto to sensors-detect, for non-interactive use. Default
> answer is assumed to every question.

Looks good to me.

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  prog/detect/sensors-detect   |   61 ++++++++++++++++++++++++++++++------------
>  prog/detect/sensors-detect.8 |   13 +++++++-
>  2 files changed, 55 insertions(+), 19 deletions(-)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2012-10-22 14:17:14.000000000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2012-10-22 14:37:48.115614548 +0200
> @@ -39,7 +39,8 @@ foreach ('/usr/sbin', '/usr/local/sbin',
>  
>  use constant NO_CACHE => 1;
>  use vars qw(@pci_adapters @chip_ids @ipmi_ifs @non_hwmon_chip_ids
> -	    $i2c_addresses_to_scan $revision @i2c_byte_cache);
> +	    $i2c_addresses_to_scan $revision @i2c_byte_cache
> +	    $opt_auto);
>  
>  $revision = '$Revision: 6057 $ ($Date: 2012-06-01 17:47:27 +0200 (ven. 01 juin 2012) $)';
>  $revision =~ s/\$\w+: (.*?) \$/$1/g;
> @@ -2457,6 +2458,16 @@ sub overlay_hash
>  	return %result;
>  }
>  
> +# Read answer from stdin or accept default answer automatically
> +sub read_answer
> +{
> +	if ($opt_auto) {
> +		print "\n";
> +		return "";
> +	}
> +	return <STDIN>;
> +}
> +
>  ###################
>  # I/O PORT ACCESS #
>  ###################
> @@ -3667,7 +3678,7 @@ sub scan_i2c_adapter
>  	       "Do you want to scan it? (\%s/selectively): ",
>  	       $default ? "YES/no" : "yes/NO";
>  
> -	$input = <STDIN>;
> +	$input = read_answer();
>  	if ($input =~ /^\s*n/i
>  	 || (!$default && $input !~ /^\s*[ys]/i)) {
>  		print "\n";
> @@ -3678,7 +3689,7 @@ sub scan_i2c_adapter
>  		print "Please enter one or more addresses not to scan. Separate them with commas.\n",
>  		      "You can specify a range by using dashes. Example: 0x58-0x5f,0x69.\n",
>  		      "Addresses: ";
> -		$input = <STDIN>;
> +		$input = read_answer();
>  		chomp($input);
>  		@not_to_scan = parse_not_to_scan(0x03, 0x77, $input);
>  	} elsif (($class & 0xff00) = 0x0300) {
> @@ -6632,7 +6643,7 @@ sub write_config
>  		printf "Do you want to \%s /etc/modprobe.d/lm_sensors.conf? (\%s): ",
>  		       (-e '/etc/modprobe.d/lm_sensors.conf' ? 'overwrite' : 'generate'),
>  		       ($have_modprobe_d ? 'YES/no' : 'yes/NO');
> -		$_ = <STDIN>;
> +		$_ = read_answer();
>  		if (($have_modprobe_d and not m/^\s*n/i) or m/^\s*y/i) {
>  			unless ($have_modprobe_d) {
>  				mkdir('/etc/modprobe.d', 0777)
> @@ -6656,7 +6667,7 @@ sub write_config
>  	printf "Do you want to \%s /etc/sysconfig/lm_sensors? (\%s): ",
>  	       (-e '/etc/sysconfig/lm_sensors' ? 'overwrite' : 'generate'),
>  	       ($have_sysconfig ? 'YES/no' : 'yes/NO');
> -	$_ = <STDIN>;
> +	$_ = read_answer();
>  	if (($have_sysconfig and not m/^\s*n/i) or m/^\s*y/i) {
>  		unless ($have_sysconfig) {
>  			mkdir('/etc/sysconfig', 0777)
> @@ -6757,6 +6768,10 @@ sub main
>  		exit 0;
>  	}
>  
> +	if (defined $ARGV[0] && $ARGV[0] eq "--auto") {
> +		$opt_auto = 1;
> +	}
> +
>  	# We won't go very far if not root
>  	unless ($> = 0) {
>  		print "You need to be root to run this script.\n";
> @@ -6784,14 +6799,21 @@ sub main
>  	initialize_dmi_data();
>  	print_dmi_summary();
>  	print "\n";
> -	print "This program will help you determine which kernel modules you need\n",
> -	      "to load to use lm_sensors most effectively. It is generally safe\n",
> -	      "and recommended to accept the default answers to all questions,\n",
> -	      "unless you know what you're doing.\n\n";
> +
> +	if ($opt_auto) {
> +		print "Running in automatic mode, default answers to all questions\n",
> +		      "are assumed.\n\n";
> +	} else {
> +		print "This program will help you determine which kernel modules you need\n",
> +		      "to load to use lm_sensors most effectively. It is generally safe\n",
> +		      "and recommended to accept the default answers to all questions,\n",
> +		      "unless you know what you're doing.\n\n";
> +	}
>  
>  	print "Some south bridges, CPUs or memory controllers contain embedded sensors.\n".
>  	      "Do you want to scan for them? This is totally safe. (YES/no): ";
> -	unless (<STDIN> =~ /^\s*n/i) {
> +	$input = read_answer();
> +	unless ($input =~ /^\s*n/i) {
>  		# Load the cpuid driver if needed
>  		unless (-e "$sysfs_root/class/cpuid") {
>  			load_module("cpuid");
> @@ -6813,7 +6835,8 @@ sub main
>  		print "Some Super I/O chips contain embedded sensors. We have to write to\n".
>  		      "standard I/O ports to probe them. This is usually safe.\n";
>  		print "Do you want to scan for Super I/O sensors? (YES/no): ";
> -		unless (<STDIN> =~ /^\s*n/i) {
> +		$input = read_answer();
> +		unless ($input =~ /^\s*n/i) {
>  			initialize_ioports();
>  			$superio_features |= scan_superio(0x2e, 0x2f);
>  			$superio_features |= scan_superio(0x4e, 0x4f);
> @@ -6828,7 +6851,8 @@ sub main
>  			      "there, we have to read from arbitrary I/O ports to probe for such\n".
>  			      "interfaces. This is normally safe. Do you want to scan for IPMI\n".
>  			      "interfaces? (YES/no): ";
> -			unless (<STDIN> =~ /^\s*n/i) {
> +			$input = read_answer();
> +			unless ($input =~ /^\s*n/i) {
>  				if (!ipmi_from_smbios()) {
>  					initialize_ioports();
>  					scan_isa_bus(\@ipmi_ifs);
> @@ -6843,7 +6867,7 @@ sub main
>  		       "safe though. Yes, you do have ISA I/O ports even if you do not have any\n".
>  		       "ISA slots! Do you want to scan the ISA I/O ports? (\%s): ",
>  		       $superio_features ? "yes/NO" : "YES/no";
> -		$input = <STDIN>;
> +		$input = read_answer();
>  		unless ($input =~ /^\s*n/i
>  		     || ($superio_features && $input !~ /^\s*y/i)) {
>  			initialize_ioports();
> @@ -6859,7 +6883,8 @@ sub main
>  	      "on some systems.\n".
>  	      "Do you want to probe the I2C/SMBus adapters now? (YES/no): ";
>  
> -	unless (<STDIN> =~ /^\s*n/i) {
> +	$input = read_answer();
> +	unless ($input =~ /^\s*n/i) {
>  		adapter_pci_detection();
>  		load_module("i2c-dev") unless -e "$sysfs_root/class/i2c-dev";
>  		initialize_i2c_adapters_list();
> @@ -6895,9 +6920,11 @@ sub main
>  		exit;
>  	}
>  
> -	print "Now follows a summary of the probes I have just done.\n".
> -	      "Just press ENTER to continue: ";
> -	<STDIN>;
> +	print "\nNow follows a summary of the probes I have just done.\n";
> +	unless ($opt_auto) {
> +		print "Just press ENTER to continue: ";
> +		<STDIN>;
> +	}
>  
>  	initialize_hwmon_autoloaded();
>  	foreach my $driver (keys %chips_detected) {
> --- lm-sensors.orig/prog/detect/sensors-detect.8	2008-12-03 16:13:14.000000000 +0100
> +++ lm-sensors/prog/detect/sensors-detect.8	2012-10-22 14:45:02.810749684 +0200
> @@ -1,9 +1,11 @@
> -.TH SENSORS-DETECT 8 "December 2008" "lm-sensors 3"
> +.TH SENSORS-DETECT 8 "October 2012" "lm-sensors 3"
>  .SH NAME
>  sensors-detect \- detect hardware monitoring chips
>  
>  .SH SYNOPSIS
> -.B sensors-detect
> +.B sensors-detect [
> +.I --auto
> +.B ]
>  
>  .SH DESCRIPTION
>  sensors-detect is an interactive program that will walk you through the
> @@ -30,6 +32,13 @@ his/her wish. This can be useful if a gi
>  hardware monitoring chip. Some vendors are known to do this, most notably
>  Asus and Tyan.
>  
> +.SH OPTIONS
> +.IP "--auto"
> +Run in automatic, non-interactive mode. Assume default answers to all
> +questions. Note that this isn't necessarily safe as the internal logic may
> +lead to potentially dangerous probes being attempted. See the WARNING section
> +below.
> +
>  .SH WARNING
>  sensors-detect needs to access the hardware for most of the chip detections.
>  By definition, it doesn't know which chips are there before it manages to
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
