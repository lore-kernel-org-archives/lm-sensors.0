From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Feb 2011 14:40:58 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Add detection for EMCD103
Message-Id: <20110218144057.GB27612@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Updated subject for clarification.

On Fri, Feb 18, 2011 at 08:15:45AM -0500, Guenter Roeck wrote:
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5933)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -547,11 +547,16 @@
>  		i2c_addrs => [0x2c..0x2e],
>  		i2c_detect => sub { lm85_detect(@_, 5); },
>  	}, {
> -		name => "SMSC EMC6D103",
> +		name => "SMSC EMC6D103 rev A0, A1",
>  		driver => "lm85",
>  		i2c_addrs => [0x2c..0x2e],
>  		i2c_detect => sub { lm85_detect(@_, 6); },
>  	}, {
> +		name => "SMSC EMC6D103 rev A2",
> +		driver => "to-be-written",	# lm85
> +		i2c_addrs => [0x2c..0x2e],
> +		i2c_detect => sub { lm85_detect(@_, 8); },
> +	}, {
>  		name => "Winbond WPCD377I",
>  		driver => "not-a-sensor",
>  		i2c_addrs => [0x2c..0x2e],
> @@ -4776,7 +4781,11 @@
>  		return if $verstep != 0x65;	# EMC6D102
>  	} elsif ($chip = 6) {
>  		return if $vendor != 0x5c;	# SMSC
> -		return if $verstep != 0x68;	# EMC6D103
> +		return if $verstep != 0x68	# EMC6D103 A0
> +		       && $verstep != 0x69;	# EMC6D103 A1
> +	} elsif ($chip = 8) {
> +		return if $vendor != 0x5c;	# SMSC
> +		return if $verstep != 0x6a;	# EMC6D103 A2
>  	}
>  
>  	if ($vendor = 0x41) {			# Analog Devices
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
