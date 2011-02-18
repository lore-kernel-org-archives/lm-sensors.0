From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 18 Feb 2011 14:51:49 +0000
Subject: Re: [lm-sensors] [PATCH] Add detection for EMCD103 chip revisions
Message-Id: <20110218155149.28e306bc@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110218131545.GB27355@ericsson.com>
In-Reply-To: <20110218131545.GB27355@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 18 Feb 2011 05:15:45 -0800, Guenter Roeck wrote:
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

For the AS99127F, where we also had to differentiate, we have the
following strings:

Asus AS99127F (rev.1)
Asus AS99127F (rev.2)

While I agree this is a minor issue, it would be nice to stay
consistent.

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

Can you please also update the "Chip to detect" comment at the top of
function lm85_detect?

Other than this, the code looks OK, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
