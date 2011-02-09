From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Feb 2011 17:28:47 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Fix address ranges checked
Message-Id: <20110209182847.46c2da76@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110209171942.GA19608@ericsson.com>
In-Reply-To: <20110209171942.GA19608@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 9 Feb 2011 09:19:42 -0800, Guenter Roeck wrote:
> Update I2C address ranges for SMSC EMC1403, EMC1404, and EMC1423 to match
> information in datasheets.
> 
> --
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5915)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -1257,17 +1257,17 @@
>  	}, {
>  		name => "SMSC EMC1403",
>  		driver => "emc1403",
> -		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> +		i2c_addrs => [0x18, 0x29, 0x4c, 0x4d],
>  		i2c_detect => sub { emc1403_detect(@_, 0); },
>  	}, {
>  		name => "SMSC EMC1404",
>  		driver => "to-be-written", # emc1403
> -		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> +		i2c_addrs => [0x18, 0x29, 0x4c, 0x4d],
>  		i2c_detect => sub { emc1403_detect(@_, 1); },
>  	}, {
>  		name => "SMSC EMC1423",
>  		driver => "emc1403",
> -		i2c_addrs => [0x18, 0x2a, 0x4c, 0x4d],
> +		i2c_addrs => [0x4c],
>  		i2c_detect => sub { emc1403_detect(@_, 3); },
>  	}, {
>  		name => "SMSC EMC1424",
> Index: CHANGES
> =================================> --- CHANGES	(revision 5915)
> +++ CHANGES	(working copy)
> @@ -24,6 +24,8 @@
>                    Add detection of Nuvoton NCT5571D, NCT5577D and NCT6776F
>                    Add detection of SMSC EMC1002, EMC1033, EMC1046, EMC1047,
>                          EMC1072, EMC1073, EMC1074, EMC1402, and EMC1424
> +                  Fixed address ranges checked for SMSC EMC1403, EMC1404,
> +                        and EMC1423.

You don't have to document if for the EMC1423, as the bogus version was
never released.

Other that this, it looks OK, go ahead and commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
