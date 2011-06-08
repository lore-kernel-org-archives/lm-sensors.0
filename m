From: Aurelien Jarno <aurelien@aurel32.net>
Date: Wed, 08 Jun 2011 14:29:06 +0000
Subject: Re: [lm-sensors] [PATCH] Don't point the user to the ipmisensors
Message-Id: <20110608142906.GA11551@hall.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110608151843.357fa29c@endymion.delvare>
In-Reply-To: <20110608151843.357fa29c@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On Wed, Jun 08, 2011 at 03:18:43PM +0200, Jean Delvare wrote:
> The development of the ipmisensors driver stalled 5 years ago, the
> driver isn't usable, so stop pointing the users to it, it only confuses
> them. See https://bugzilla.novell.com/show_bug.cgi?idU8756 for
> example.

I think I never tried this driver, but I trust you on this analysis.

> ---
> I have this patch in openSUSE for 1.5 year, any objection to me
> getting it upstream for everyone's benefit?

Given the above, I think it's a good idea.


>  prog/detect/sensors-detect |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2011-06-08 14:59:16.000000000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2011-06-08 15:12:04.000000000 +0200
> @@ -1356,12 +1356,12 @@ use vars qw(@i2c_adapter_names);
>  @ipmi_ifs = (
>  	{
>  		name => "IPMI BMC KCS",
> -		driver => "ipmisensors",
> +		driver => "to-be-written",	# ipmisensors
>  		isa_addrs => [0x0ca0],
>  		isa_detect => sub { ipmi_detect(@_); },
>  	}, {
>  		name => "IPMI BMC SMIC",
> -		driver => "ipmisensors",
> +		driver => "to-be-written",	# ipmisensors
>  		isa_addrs => [0x0ca8],
>  		isa_detect => sub { ipmi_detect(@_); },
>  	}
> @@ -6039,6 +6039,7 @@ sub w83781d_isa_detect
>  sub ipmi_from_smbios
>  {
>  	my ($version, $if, @ipmi_if);
> +	my $ipmi_driver = "to-be-written";	# ipmisensors
>  
>  	return 0 unless check_dmidecode_version();
>  
> @@ -6074,13 +6075,13 @@ sub ipmi_from_smbios
>  						 $if->{type}));
>  		}
>  		print "Success!\n".
> -		      "    (confidence 8, driver `ipmisensors')\n";
> +		      "    (confidence 8, driver `$ipmi_driver')\n";
>  		my $new_hash = {
>  			conf => 8,
>  			isa_addr => $if->{addr} || 0,
>  			chipname => $if->{type},
>  		};
> -		add_isa_to_chips_detected("ipmisensors", $new_hash);
> +		add_isa_to_chips_detected($ipmi_driver, $new_hash);
>  	}
>  
>  	return scalar @ipmi_if;
> 
> 
> -- 
> Jean Delvare
> 

-- 
Aurelien Jarno	                        GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
