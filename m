From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 13 Sep 2010 18:18:24 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Add support for IT8512E/F and
Message-Id: <20100913201824.2c51bbcd@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284401775-2214-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284401775-2214-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 13 Sep 2010 11:16:15 -0700, Guenter Roeck wrote:
> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5858)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -1448,6 +1448,11 @@
>  		devid => 0xf2,
>  		logdev => 0x14,
>  		features => FEAT_IN | FEAT_TEMP,
> +	}, {
> +		# Shouldn't be in this family, but there it is
> +		name => "ITE IT8512E/F Super IO",
> +		driver => "not-a-sensor",
> +		devid => 0x8512,
>  	}
>  );
>  
> @@ -1914,7 +1919,7 @@
>  		logdev => 0x04,
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}, {
> -		name => "ITE IT8721F Super IO Sensors",
> +		name => "ITE IT8721F/IT8758E Super IO Sensors",
>  		driver => "to-be-written",	# it87
>  		devid => 0x8721,
>  		logdev => 0x04,
> Index: CHANGES
> =================================> --- CHANGES	(revision 5857)
> +++ CHANGES	(working copy)
> @@ -24,6 +24,7 @@
>                    Add support for NXP SE97 / SE97B
>                    Add reference to NCT6771F/NCT6772F/NCT6775F
>                    Add support for several JC42.4 compliant temperature sensors
> +                  Add support for ITE IT8512E/F and IT8758E
>  
>  3.1.2 (2010-02-02)
>    libsensors: Support upcoming sysfs path to i2c adapters

Looks good, feel free to commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
