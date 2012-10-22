From: Adrian Sevcenco <Adrian.Sevcenco@cern.ch>
Date: Mon, 22 Oct 2012 13:23:19 +0000
Subject: Re: [lm-sensors] non-interactive sensors-detect
Message-Id: <508548C7.8030203@cern.ch>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7895830615767405087=="
List-Id: <lm-sensors.vger.kernel.org>
References: <507BD5C2.8050506@cern.ch>
In-Reply-To: <507BD5C2.8050506@cern.ch>
To: lm-sensors@vger.kernel.org

--===============7895830615767405087==
Content-Type: multipart/signed; protocol="application/pkcs7-signature";
	micalg=sha1; boundary="------------ms020108030800060301000501"

--------------ms020108030800060301000501
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/22/2012 03:47 PM, Jean Delvare wrote:
> On Mon, 15 Oct 2012 12:22:10 +0300, Adrian Sevcenco wrote:
>> Hi! Is there a way to run sensors-detect in a non-interactive way?
>> I try to enable lm_sensors on a cluster and i find no way to do it..
>> Is is possible to add switches like -y (yes all) or -d (default all) t=
o=20
>> sensors detect?
>=20
> Proposal below. It doesn't feel too safe as random I2C adapters may
> still get probed. But it's definitely better that people trying to get
> a non-interactive sensors-detect using "yes |".
Great, thanks!
is this applied to trunk or should i apply the patch to a fresh trunk
and rebuild?

Thanks a lot!
Adrian

> sensors-detect: Introduce automatic mode
>=20
> Add option --auto to sensors-detect, for non-interactive use. Default
> answer is assumed to every question.
> ---
>  prog/detect/sensors-detect   |   61 ++++++++++++++++++++++++++++++----=
--------
>  prog/detect/sensors-detect.8 |   13 +++++++-
>  2 files changed, 55 insertions(+), 19 deletions(-)
>=20
> --- lm-sensors.orig/prog/detect/sensors-detect	2012-10-22 14:17:14.0000=
00000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2012-10-22 14:37:48.115614548=
 +0200
> @@ -39,7 +39,8 @@ foreach ('/usr/sbin', '/usr/local/sbin',
> =20
>  use constant NO_CACHE =3D> 1;
>  use vars qw(@pci_adapters @chip_ids @ipmi_ifs @non_hwmon_chip_ids
> -	    $i2c_addresses_to_scan $revision @i2c_byte_cache);
> +	    $i2c_addresses_to_scan $revision @i2c_byte_cache
> +	    $opt_auto);
> =20
>  $revision =3D '$Revision: 6057 $ ($Date: 2012-06-01 17:47:27 +0200 (ve=
n. 01 juin 2012) $)';
>  $revision =3D~ s/\$\w+: (.*?) \$/$1/g;
> @@ -2457,6 +2458,16 @@ sub overlay_hash
>  	return %result;
>  }
> =20
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
> =20
> -	$input =3D <STDIN>;
> +	$input =3D read_answer();
>  	if ($input =3D~ /^\s*n/i
>  	 || (!$default && $input !~ /^\s*[ys]/i)) {
>  		print "\n";
> @@ -3678,7 +3689,7 @@ sub scan_i2c_adapter
>  		print "Please enter one or more addresses not to scan. Separate them=
 with commas.\n",
>  		      "You can specify a range by using dashes. Example: 0x58-0x5f,0=
x69.\n",
>  		      "Addresses: ";
> -		$input =3D <STDIN>;
> +		$input =3D read_answer();
>  		chomp($input);
>  		@not_to_scan =3D parse_not_to_scan(0x03, 0x77, $input);
>  	} elsif (($class & 0xff00) =3D=3D 0x0300) {
> @@ -6632,7 +6643,7 @@ sub write_config
>  		printf "Do you want to \%s /etc/modprobe.d/lm_sensors.conf? (\%s): "=
,
>  		       (-e '/etc/modprobe.d/lm_sensors.conf' ? 'overwrite' : 'genera=
te'),
>  		       ($have_modprobe_d ? 'YES/no' : 'yes/NO');
> -		$_ =3D <STDIN>;
> +		$_ =3D read_answer();
>  		if (($have_modprobe_d and not m/^\s*n/i) or m/^\s*y/i) {
>  			unless ($have_modprobe_d) {
>  				mkdir('/etc/modprobe.d', 0777)
> @@ -6656,7 +6667,7 @@ sub write_config
>  	printf "Do you want to \%s /etc/sysconfig/lm_sensors? (\%s): ",
>  	       (-e '/etc/sysconfig/lm_sensors' ? 'overwrite' : 'generate'),
>  	       ($have_sysconfig ? 'YES/no' : 'yes/NO');
> -	$_ =3D <STDIN>;
> +	$_ =3D read_answer();
>  	if (($have_sysconfig and not m/^\s*n/i) or m/^\s*y/i) {
>  		unless ($have_sysconfig) {
>  			mkdir('/etc/sysconfig', 0777)
> @@ -6757,6 +6768,10 @@ sub main
>  		exit 0;
>  	}
> =20
> +	if (defined $ARGV[0] && $ARGV[0] eq "--auto") {
> +		$opt_auto =3D 1;
> +	}
> +
>  	# We won't go very far if not root
>  	unless ($> =3D=3D 0) {
>  		print "You need to be root to run this script.\n";
> @@ -6784,14 +6799,21 @@ sub main
>  	initialize_dmi_data();
>  	print_dmi_summary();
>  	print "\n";
> -	print "This program will help you determine which kernel modules you =
need\n",
> -	      "to load to use lm_sensors most effectively. It is generally sa=
fe\n",
> -	      "and recommended to accept the default answers to all questions=
,\n",
> -	      "unless you know what you're doing.\n\n";
> +
> +	if ($opt_auto) {
> +		print "Running in automatic mode, default answers to all questions\n=
",
> +		      "are assumed.\n\n";
> +	} else {
> +		print "This program will help you determine which kernel modules you=
 need\n",
> +		      "to load to use lm_sensors most effectively. It is generally s=
afe\n",
> +		      "and recommended to accept the default answers to all question=
s,\n",
> +		      "unless you know what you're doing.\n\n";
> +	}
> =20
>  	print "Some south bridges, CPUs or memory controllers contain embedde=
d sensors.\n".
>  	      "Do you want to scan for them? This is totally safe. (YES/no): =
";
> -	unless (<STDIN> =3D~ /^\s*n/i) {
> +	$input =3D read_answer();
> +	unless ($input =3D~ /^\s*n/i) {
>  		# Load the cpuid driver if needed
>  		unless (-e "$sysfs_root/class/cpuid") {
>  			load_module("cpuid");
> @@ -6813,7 +6835,8 @@ sub main
>  		print "Some Super I/O chips contain embedded sensors. We have to wri=
te to\n".
>  		      "standard I/O ports to probe them. This is usually safe.\n";
>  		print "Do you want to scan for Super I/O sensors? (YES/no): ";
> -		unless (<STDIN> =3D~ /^\s*n/i) {
> +		$input =3D read_answer();
> +		unless ($input =3D~ /^\s*n/i) {
>  			initialize_ioports();
>  			$superio_features |=3D scan_superio(0x2e, 0x2f);
>  			$superio_features |=3D scan_superio(0x4e, 0x4f);
> @@ -6828,7 +6851,8 @@ sub main
>  			      "there, we have to read from arbitrary I/O ports to probe for=
 such\n".
>  			      "interfaces. This is normally safe. Do you want to scan for I=
PMI\n".
>  			      "interfaces? (YES/no): ";
> -			unless (<STDIN> =3D~ /^\s*n/i) {
> +			$input =3D read_answer();
> +			unless ($input =3D~ /^\s*n/i) {
>  				if (!ipmi_from_smbios()) {
>  					initialize_ioports();
>  					scan_isa_bus(\@ipmi_ifs);
> @@ -6843,7 +6867,7 @@ sub main
>  		       "safe though. Yes, you do have ISA I/O ports even if you do n=
ot have any\n".
>  		       "ISA slots! Do you want to scan the ISA I/O ports? (\%s): ",
>  		       $superio_features ? "yes/NO" : "YES/no";
> -		$input =3D <STDIN>;
> +		$input =3D read_answer();
>  		unless ($input =3D~ /^\s*n/i
>  		     || ($superio_features && $input !~ /^\s*y/i)) {
>  			initialize_ioports();
> @@ -6859,7 +6883,8 @@ sub main
>  	      "on some systems.\n".
>  	      "Do you want to probe the I2C/SMBus adapters now? (YES/no): ";
> =20
> -	unless (<STDIN> =3D~ /^\s*n/i) {
> +	$input =3D read_answer();
> +	unless ($input =3D~ /^\s*n/i) {
>  		adapter_pci_detection();
>  		load_module("i2c-dev") unless -e "$sysfs_root/class/i2c-dev";
>  		initialize_i2c_adapters_list();
> @@ -6895,9 +6920,11 @@ sub main
>  		exit;
>  	}
> =20
> -	print "Now follows a summary of the probes I have just done.\n".
> -	      "Just press ENTER to continue: ";
> -	<STDIN>;
> +	print "\nNow follows a summary of the probes I have just done.\n";
> +	unless ($opt_auto) {
> +		print "Just press ENTER to continue: ";
> +		<STDIN>;
> +	}
> =20
>  	initialize_hwmon_autoloaded();
>  	foreach my $driver (keys %chips_detected) {
> --- lm-sensors.orig/prog/detect/sensors-detect.8	2008-12-03 16:13:14.00=
0000000 +0100
> +++ lm-sensors/prog/detect/sensors-detect.8	2012-10-22 14:45:02.8107496=
84 +0200
> @@ -1,9 +1,11 @@
> -.TH SENSORS-DETECT 8 "December 2008" "lm-sensors 3"
> +.TH SENSORS-DETECT 8 "October 2012" "lm-sensors 3"
>  .SH NAME
>  sensors-detect \- detect hardware monitoring chips
> =20
>  .SH SYNOPSIS
> -.B sensors-detect
> +.B sensors-detect [
> +.I --auto
> +.B ]
> =20
>  .SH DESCRIPTION
>  sensors-detect is an interactive program that will walk you through th=
e
> @@ -30,6 +32,13 @@ his/her wish. This can be useful if a gi
>  hardware monitoring chip. Some vendors are known to do this, most nota=
bly
>  Asus and Tyan.
> =20
> +.SH OPTIONS
> +.IP "--auto"
> +Run in automatic, non-interactive mode. Assume default answers to all
> +questions. Note that this isn't necessarily safe as the internal logic=
 may
> +lead to potentially dangerous probes being attempted. See the WARNING =
section
> +below.
> +
>  .SH WARNING
>  sensors-detect needs to access the hardware for most of the chip detec=
tions.
>  By definition, it doesn't know which chips are there before it manages=
 to
>=20



--------------ms020108030800060301000501
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIEZjCC
BGIwggNKoAMCAQICAgMJMA0GCSqGSIb3DQEBBQUAMH0xEjAQBgoJkiaJk/IsZAEZEwJSTzEc
MBoGCgmSJomT8ixkARkTDFJvbWFuaWFuR1JJRDENMAsGA1UEChMEUk9TQTEgMB4GA1UECxMX
Q2VydGlmaWNhdGlvbiBBdXRob3JpdHkxGDAWBgNVBAMTD1JvbWFuaWFuR1JJRCBDQTAeFw0x
MjA4MDMxMjE0MzZaFw0xMzA4MDMxMjE0MzZaMFoxEjAQBgoJkiaJk/IsZAEZFgJSTzEcMBoG
CgmSJomT8ixkARkWDFJvbWFuaWFuR1JJRDEMMAoGA1UEChMDSVNTMRgwFgYDVQQDEw9BZHJp
YW4gU0VWQ0VOQ08wgZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMrO1Aw5cgA7NLLkiq2o
TUkonX1ADWcMjQl1HyVZVeC7gqzKuuHSBw024EX9eQR6xTJ79uSn0nJL/MNO3xbXBK7dQo/5
GdmODhOAeNSnAv6XV/tO+jcGmr+LOEqCWgBvCfuJlHJViHc5rvwjXsrq1ovMiyvDqmH+yAv5
bkO0z2SJAgMBAAGjggGRMIIBjTAMBgNVHRMBAf8EAjAAMBEGCWCGSAGG+EIBAQQEAwIFoDAO
BgNVHQ8BAf8EBAMCBLAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQW
BBSMGoTSxCvW/nR+OCVNXjumI1WrRzAfBgNVHSMEGDAWgBR/EM1cbqzKaxIL4KmHiBGVvDAX
aDBjBgNVHSAEXDBaMFgGDisGAQQBgdNfCQECAQEEMEYwRAYIKwYBBQUHAgEWOGh0dHA6Ly93
d3cucm9tYW5pYW5ncmlkLnJvL2RvY3MvUm9tYW5pYW5HUklEX0NBX3YxLjQucGRmMDoGA1Ud
HwQzMDEwL6AtoCuGKWh0dHA6Ly93d3cucm9tYW5pYW5ncmlkLnJvL2NybC9jcmwtdjIuZGVy
MDYGA1UdEgQvMC2BD2dyaWQtY2FAcm9zYS5yb4YaaHR0cDovL3d3dy5yb21hbmlhbmdyaWQu
cm8wIgYDVR0RBBswGYEXYWRyaWFuLnNldmNlbmNvQGNlcm4uY2gwDQYJKoZIhvcNAQEFBQAD
ggEBAIOTq6S3fD6krVaH2nKeqXa1cJuBSokV+aZ3oS1gBI0HLCabFK+Moy7eFj1PTGLAA+VR
s2O/wVkyVnoU5+uUXkhl2yEQBcwLg9wsafK+7w0u0AfNH4ygJPTeBaKjECnWq1cAKA7vesQA
7qQhp4WVdQGGmEqjZ2NInk/j8HU9dK8UKxfu1WS1WarFmfGmXKxgvSxwOPajy7bgVW32rMuE
9r0tUaTC51sPSxnxHyssx0duhVEdZlKIz+l4+pmNfS1WZ2lYF/c8doj1vRtD2wVCGnbs0dHb
znvr+ljy0n1tm7yirGnNVLUWWwN94OlV6J8OKJP6kJqjkv/+E8Og0t7wu9ExggMpMIIDJQIB
ATCBgzB9MRIwEAYKCZImiZPyLGQBGRMCUk8xHDAaBgoJkiaJk/IsZAEZEwxSb21hbmlhbkdS
SUQxDTALBgNVBAoTBFJPU0ExIDAeBgNVBAsTF0NlcnRpZmljYXRpb24gQXV0aG9yaXR5MRgw
FgYDVQQDEw9Sb21hbmlhbkdSSUQgQ0ECAgMJMAkGBSsOAwIaBQCgggH7MBgGCSqGSIb3DQEJ
AzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTEyMTAyMjEzMjMxOVowIwYJKoZIhvcN
AQkEMRYEFMnkQNbmHLJ+Uf31kZiImnk3F5VUMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgZQGCSsGAQQBgjcQBDGBhjCBgzB9MRIw
EAYKCZImiZPyLGQBGRMCUk8xHDAaBgoJkiaJk/IsZAEZEwxSb21hbmlhbkdSSUQxDTALBgNV
BAoTBFJPU0ExIDAeBgNVBAsTF0NlcnRpZmljYXRpb24gQXV0aG9yaXR5MRgwFgYDVQQDEw9S
b21hbmlhbkdSSUQgQ0ECAgMJMIGWBgsqhkiG9w0BCRACCzGBhqCBgzB9MRIwEAYKCZImiZPy
LGQBGRMCUk8xHDAaBgoJkiaJk/IsZAEZEwxSb21hbmlhbkdSSUQxDTALBgNVBAoTBFJPU0Ex
IDAeBgNVBAsTF0NlcnRpZmljYXRpb24gQXV0aG9yaXR5MRgwFgYDVQQDEw9Sb21hbmlhbkdS
SUQgQ0ECAgMJMA0GCSqGSIb3DQEBAQUABIGAeWGs35zvFBXqimN8N89Q/bbb5fFOdW+YCkJJ
2jWn5O3wmOowYKgaJSKLLOvl5lgL+hcwq7oPLLtSpIeSJL8duLo6P6uQQDCCiDAT49tnBmt/
NlmVgjVV3D2QHPY63iR7rt4XPhHGwvS19CXGJnS/Sa9AYYvRe3fy+T6fRKN01YkAAAAAAAA=
--------------ms020108030800060301000501--


--===============7895830615767405087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7895830615767405087==--
