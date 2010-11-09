From: Anand Gadiyar <gadiyar@ti.com>
Date: Tue, 09 Nov 2010 13:52:07 +0000
Subject: Re: [lm-sensors] [PATCH V2] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <6d8d369473ef89e6b2c20252b7007b8a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1289294457-5330-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: J KEERTHY <j-keerthy@ti.com>, lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org
Cc: mikko.k.ylinen@nokia.com, Felipe Balbi <balbi@ti.com>, amit.kucheria@canonical.com, linux-omap@vger.kernel.org, Balaji T Krishnamoorthy <balajitk@ti.com>

> Introducing a driver for MADC on TWL4030 powerIC. MADC stands for
monitoring
> ADC. This driver monitors the real time conversion of analog signals
like
> battery temperature, battery type, battery level etc. User can also ask
for
> the conversion on a particular channel using the sysfs nodes.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>

...


> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a56f6ad..fef75f2 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1171,6 +1171,12 @@ config SENSORS_MC13783_ADC
>          help
>            Support for the A/D converter on MC13783 PMIC.
>
> +config SENSORS_TWL4030_MADC
> +	tristate

You need to provide some label text here, otherwise this option
will not show up in the kernel configuration tools, and hence
cannot be turned on or off from there.

- Anand

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
