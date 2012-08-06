From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Aug 2012 17:39:43 +0000
Subject: Re: [lm-sensors] [NEW DRIVER V2 6/7] DA9058 HWMON driver
Message-Id: <20120806173943.GA29475@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208060737.q767biox005703@ubuntu>
In-Reply-To: <201208060737.q767biox005703@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Anthony Olech <anthony.olech.opensource@diasemi.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Randy Dunlop <randy.dunlap@oracle.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Dajun Chen <david.chen@diasemi.com>, LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Sun, Aug 05, 2012 at 09:43:44PM +0100, Anthony Olech wrote:
> This is the HWMON component driver of the Dialog DA9058 PMIC.
> This driver is just one component of the whole DA9058 PMIC driver.
> It depends on the core DA9058 MFD driver.
> 
> Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
> Signed-off-by: David Dajun Chen <david.chen@diasemi.com>

[ ... ]

> +static SENSOR_DEVICE_ATTR(vbat_mV, S_IRUGO, da9058_read_vbat, NULL, 0);
> +static SENSOR_DEVICE_ATTR(adc_mV, S_IRUGO, da9058_read_misc_channel, NULL,
> +				DA9058_ADCMAN_MUXSEL_ADCIN);
> +static SENSOR_DEVICE_ATTR(vfpin_mV, S_IRUGO, da9058_read_vfpin, NULL, 0);
> +static SENSOR_DEVICE_ATTR(vfpin_mode, S_IRUGO, da9058_vfpin_mode, NULL, 0);
> +static SENSOR_DEVICE_ATTR(tbat_mV, S_IRUGO, da9058_read_tbat, NULL, 0);
> +static SENSOR_DEVICE_ATTR(tjunc_in, S_IRUGO, da9058_read_tjunc, NULL, 0);
> +static SENSOR_DEVICE_ATTR(adc_mode, S_IWUSR | S_IRUGO, da9058_get_adc_mode,
> +				da9058_set_adc_mode, 0);

Please use standard sysfs attribute names for temperature and voltage attributes.
For configuration (XXX_mode), please use devicetreee and/or platform data, not
sysfs attributes.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
