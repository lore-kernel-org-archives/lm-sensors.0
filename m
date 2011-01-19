From: Jeff Rickman <jrickman@myamigos.us>
Date: Wed, 19 Jan 2011 05:50:28 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <4D367BA4.7040002@myamigos.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On 1/18/2011 4:35 PM, Jean Delvare wrote:
> On Tue, 18 Jan 2011 17:32:46 +0100, Jean Delvare wrote:
>> On Tue, 18 Jan 2011 10:03:23 -0600, Nick Hall wrote:
>>> And regarding the sensors-detect script, I understand now. If anyone is
>>> interested, my Sandy Bridge processor would be model "0x2A" according t=
o how
>>> that script does things.
>>
>> This is an option, yes, but it would be better if we could implement
>> the same detection logic as the coretemp driver has. For one thing, this
>> would guarantee that the two are always in sync. For another, it would
>> lower the maintenance effort from our side, as the new detection logic
>> is universal and doesn't need to be updated with every new CPU model.
>> I'm looking into it but this is non-trivial.
>
> I have come up with the following patch:
>
> Index: prog/detect/sensors-detect
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- prog/detect/sensors-detect	(r=E9vision 590=
4)
> +++ prog/detect/sensors-detect	(copie de travail)
> @@ -23,7 +23,7 @@
>   require 5.004;
>
>   use strict;
> -use Fcntl;
> +use Fcntl qw(:DEFAULT :seek);
>   use File::Basename;
>
>   # We will call modprobe, which typically lives in either /sbin,
> @@ -2046,14 +2046,10 @@
>   		driver =3D>  "k10temp",
>   		detect =3D>  \&fam11h_pci_detect,
>   	}, {
> -		name =3D>  "Intel Core family thermal sensor",
> +		name =3D>  "Intel digital thermal sensor",
>   		driver =3D>  "coretemp",
> -		detect =3D>  sub { coretemp_detect(0); },
> +		detect =3D>  \&coretemp_detect,
>   	}, {
> -		name =3D>  "Intel Atom thermal sensor",
> -		driver =3D>  "coretemp",
> -		detect =3D>  sub { coretemp_detect(1); },
> -	}, {
>   		name =3D>  "Intel AMB FB-DIMM thermal sensor",
>   		driver =3D>  "i5k_amb",
>   		detect =3D>  \&intel_amb_detect,
> @@ -2314,10 +2310,10 @@
>   	while (<INPUTFILE>) {
>   		if (m/^processor\s*:\s*(\d+)/) {
>   			push @cpu, $entry if scalar keys(%{$entry}); # Previous entry
> -			$entry =3D {}; # New entry
> +			$entry =3D { nr =3D>  $1 }; # New entry
>   			next;
>   		}
> -		if (m/^(vendor_id|cpu family|model|model name|stepping)\s*:\s*(.+)$/) {
> +		if (m/^(vendor_id|cpu family|model|model name|stepping|cpuid level)\s*=
:\s*(.+)$/) {
>   			my $k =3D $1;
>   			my $v =3D $2;
>   			$v =3D~ s/\s+/ /g;	# Merge multiple spaces
> @@ -2486,6 +2482,15 @@
>   	$modules_list{$normalized} =3D 1;
>   }
>
> +# udev may take some time to create device nodes when loading modules
> +sub udev_settle
> +{
> +	if (!(-x "/sbin/udevadm"&&  system("/sbin/udevadm settle") =3D 0)
> +	&&  !(-x "/sbin/udevsettle"&&  system("/sbin/udevsettle") =3D 0)) {
> +		sleep(1);
> +	}
> +}
> +
>   sub initialize_modules_supported
>   {
>   	foreach my $chip (@chip_ids) {
> @@ -5833,23 +5838,33 @@
>   	return;
>   }
>
> +sub cpuid
> +{
> +	my ($cpu_nr, $eax) =3D @_;
> +
> +	sysopen(CPUID, "/dev/cpu/$cpu_nr/cpuid", O_RDONLY) or return;
> +	binmode CPUID;
> +	sysseek(CPUID, $eax, SEEK_SET)
> +		or die "Cannot seek /dev/cpu/$cpu_nr/cpuid";
> +	sysread(CPUID, my $data, 16)
> +		or die "Cannot read /dev/cpu/$cpu_nr/cpuid";
> +	close CPUID;
> +
> +	return unpack("L4", $data);
> +}
> +
>   sub coretemp_detect
>   {
> -	my $chip =3D shift;
>   	my $probecpu;
>
>   	foreach $probecpu (@cpu) {
>   		next unless $probecpu->{vendor_id} eq 'GenuineIntel'&&
> -			    $probecpu->{'cpu family'} =3D 6;
> -		return 9 if $chip =3D 0&&
> -			($probecpu->{model} =3D 14 ||	# Pentium M DC
> -			 $probecpu->{model} =3D 15 ||	# Core 2 DC 65nm
> -			 $probecpu->{model} =3D 0x16 ||	# Core 2 SC 65nm
> -			 $probecpu->{model} =3D 0x17 ||	# Penryn 45nm
> -			 $probecpu->{model} =3D 0x1a ||	# Nehalem
> -			 $probecpu->{model} =3D 0x1e);	# Lynnfield
> -		return 9 if $chip =3D 1&&
> -			($probecpu->{model} =3D 0x1c);	# Atom
> +			    $probecpu->{'cpuid level'}>=3D 6;
> +
> +		# Now we check for the DTS flag
> +		my @regs =3D cpuid($probecpu->{nr}, 0x06);
> +		return unless @regs =3D 4;
> +		return 9 if ($regs[0]&  (1<<  0));	# eax, bit 0
>   	}
>   	return;
>   }
> @@ -6203,6 +6218,12 @@
>   	print "Some south bridges, CPUs or memory controllers contain embedded=
 sensors.\n".
>   	      "Do you want to scan for them? This is totally safe. (YES/no): ";
>   	unless (<STDIN>  =3D~ /^\s*n/i) {
> +		# Load the cpuid driver if needed
> +		if (@cpu>=3D 1&&  ! -e "/dev/cpu/$cpu[0]->{nr}/cpuid") {
> +			load_module("cpuid");
> +			udev_settle();
> +		}
> +
>   		$| =3D 1;
>   		foreach my $entry (@cpu_ids) {
>   			scan_cpu($entry);
> @@ -6278,12 +6299,7 @@
>   		$by_default =3D 1 if dmi_match('board_vendor', 'asustek', 'tyan',
>   					     'supermicro');
>
> -		# udev may take some time to create the device node
> -		if (!(-x "/sbin/udevadm"&&  system("/sbin/udevadm settle") =3D 0)
> -		&&  !(-x "/sbin/udevsettle"&&  system("/sbin/udevsettle") =3D 0)) {
> -			sleep(1);
> -		}
> -
> +		udev_settle();
>   		for (my $dev_nr =3D 0; $dev_nr<  @i2c_adapters; $dev_nr++) {
>   			next unless exists $i2c_adapters[$dev_nr];
>   			scan_i2c_adapter($dev_nr, $by_default);
>
> This seems to do the trick for me. Obviously it assumes that the cpuid
> kernel driver is available. All my systems have it available as a
> module, but I don't know if we can reasonably assume that it will be
> available on all x86 systems where sensors-detect is used.
>
> I would like this change to get as wide a test coverage as possible.
> To make testing easier, I've made the full script available for
> download at:
>    http://khali.linux-fr.org/devel/misc/sensors-detect
> (It's exactly equivalent to sensors-detect SVN + the patch above.) In
> particular, this needs testing on Intel CPUs with cpuid level>=3D 6 but
> without DTS support... if such systems exist (I don't have any here,
> for sure.)
>
> If this appears to work for everyone and nobody comes up with a major
> objection, then we have our fix.
>
> Thanks,

Tested on Intel Atom 230, Intel Atom 330, Intel Atom 510. CPU sensors=20
correctly detected in all 3 tests.

Tested on AMD Athlon 64 X2 5400+. AMD K8 sensors were correctly=20
detected. As expected, no Intel sensors were detected.

Tested on VIA C7-D CPU 1500MHz. VIA C7 CPU sensors were detected. As=20
expected, no Intel sensors were detected.

Fedora Core 14 i386 or x86_64 used. Kernel 2.6.35.10-74 in all cases.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
