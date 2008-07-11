From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 11 Jul 2008 07:30:43 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: Add more chip detection
Message-Id: <20080711093043.5a3f2d36@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0807101237g2a6e04a6i82660fdd7959d3af@mail.gmail.com>
In-Reply-To: <191fb4ca0807101237g2a6e04a6i82660fdd7959d3af@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

Please set the attachment type to text/plain next time.

On Thu, 10 Jul 2008 12:37:26 -0700, Juerg Haefliger wrote:
> Add detection of VIA VT1212 and SMSC EMC2700LPC Super IOs.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

> Index: lm-sensors-3.0.0/prog/detect/sensors-detect
> =================================> --- lm-sensors-3.0.0.orig/prog/detect/sensors-detect	2008-07-10 12:16:17.709353000 -0700
> +++ lm-sensors-3.0.0/prog/detect/sensors-detect	2008-07-10 12:28:41.895364000 -0700
> @@ -1666,6 +1666,11 @@
>  	devid => 0x77,
>        },
>        {
> +	name => "SMSC EMC2700LPC Super IO",
> +	# no datasheet
> +	devid => 0x67,
> +      },
> +      {
>  	name => "SMSC FDC37B72x Super IO",
>  	driver => "not-a-sensor",
>  	devid => 0x4c,
> @@ -1908,6 +1913,11 @@
>  	alias_detect => sub { vt1211_alias_detect(@_); },
>        },
>        {
> +	name => "VIA VT1212 Super IO Lite",
> +	driver => "not-a-sensor",
> +	devid => 0x3f,

Are you sure? On Wilken's system, which according to the documentation
has a VT1212 chip, sensors-detect says:

Found unknown chip with ID 0xfc01

Which would mean a devid value of 0xfc rather then 0x3f.

> +      },
> +      {
>  	name => "Winbond W83627HF/F/HG/G Super IO Sensors",
>  	driver => "w83627hf",
>  	devid => 0x52,

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
