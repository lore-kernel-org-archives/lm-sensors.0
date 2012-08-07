From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 Aug 2012 15:09:49 +0000
Subject: Re: [lm-sensors] [NEW DRIVER V2 6/7] DA9058 HWMON driver
Message-Id: <20120807150949.GA25007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208060737.q767biox005703@ubuntu>
 <20120806173943.GA29475@roeck-us.net>
 <24DF37198A1E704D9811D8F72B87EB51032C3BBB@NB-EX-MBX02.diasemi.com>
In-Reply-To: <24DF37198A1E704D9811D8F72B87EB51032C3BBB@NB-EX-MBX02.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Opensource [Anthony Olech]" <anthony.olech.opensource@diasemi.com>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>, Randy Dunlop <randy.dunlap@oracle.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, David Dajun Chen <david.chen@diasemi.com>, LKML <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Tue, Aug 07, 2012 at 12:10:08PM +0000, Opensource [Anthony Olech] wrote:
> > -----Original Message-----
> > From: Guenter Roeck [mailto:linux@roeck-us.net]
> > Sent: 06 August 2012 18:40
> > To: Opensource [Anthony Olech]
> > Cc: Guenter Roeck; Jean Delvare; Randy Dunlop; Mark Brown; David Dajun
> > Chen; LKML; lm-sensors@lm-sensors.org
> > Subject: Re: [lm-sensors] [NEW DRIVER V2 6/7] DA9058 HWMON driver
> > On Sun, Aug 05, 2012 at 09:43:44PM +0100, Anthony Olech wrote:
> > > This is the HWMON component driver of the Dialog DA9058 PMIC.
> > > This driver is just one component of the whole DA9058 PMIC driver.
> > > It depends on the core DA9058 MFD driver.
> > > Signed-off-by: Anthony Olech <anthony.olech.opensource@diasemi.com>
> > > Signed-off-by: David Dajun Chen <david.chen@diasemi.com>
> > [ ... ]
> > > +static SENSOR_DEVICE_ATTR(vbat_mV, S_IRUGO, da9058_read_vbat, NULL,
> > > +0); static SENSOR_DEVICE_ATTR(adc_mV, S_IRUGO,
> > da9058_read_misc_channel, NULL,
> > > +				DA9058_ADCMAN_MUXSEL_ADCIN);
> > > +static SENSOR_DEVICE_ATTR(vfpin_mV, S_IRUGO, da9058_read_vfpin,
> > NULL,
> > > +0); static SENSOR_DEVICE_ATTR(vfpin_mode, S_IRUGO,
> > da9058_vfpin_mode,
> > > +NULL, 0); static SENSOR_DEVICE_ATTR(tbat_mV, S_IRUGO,
> > > +da9058_read_tbat, NULL, 0); static SENSOR_DEVICE_ATTR(tjunc_in,
> > > +S_IRUGO, da9058_read_tjunc, NULL, 0); static
> > SENSOR_DEVICE_ATTR(adc_mode, S_IWUSR | S_IRUGO,
> > da9058_get_adc_mode,
> > > +				da9058_set_adc_mode, 0);
> > Please use standard sysfs attribute names for temperature and voltage attributes.
> 
> I could not find a naming convention, so I will try to abstract one from all the

Documentation/hwmon/sysfs-interface might be a good start.

> HWMON driver that have your name in them. I noted when searching that
> I missed out a file in also that Documentation/hwmon. I will correct both
> issues in my next submission attempt.
> 
> > For configuration (XXX_mode), please use devicetreee and/or platform data,
> > not sysfs attributes.
> 
> As far as I can see both devicetreee and platform data allow configuration
> data to be passed into the driver at "probe" time, they don't allow an operating
> mode to be changed dynamically. That is what I thought sysfs allowed. Thus
> your comments seem to imply that you do not want to allow the mode to be
> changed dynamically. If that is the case then I can remove the dynamic mode

Correct.

> setting, leaving it fixed by platform data.
> 

I would also suggest to read and follow Documentation/hwmon/submitting-patches.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
