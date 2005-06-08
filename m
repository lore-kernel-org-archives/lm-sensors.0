From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 08 Jun 2005 07:54:39 +0000
Subject: [lm-sensors] Re: 2.6.12-rc6-mm1
Message-Id: <20050608075340.12bd49e9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
	<200506072259.52848.soren3@gmail.com>
In-Reply-To: <200506072259.52848.soren3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: =?ISO-8859-1?Q?S=F8ren?= Lott <soren3@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Soren,

> [snip]
> 
> > +gregkh-i2c-i2c-Kconfig-update.patch
> > +gregkh-i2c-i2c-pcf8574-cleanup.patch
> > +gregkh-i2c-i2c-adm9240-docs.patch
> > +gregkh-i2c-i2c-device-attr-lm90.patch
> > +gregkh-i2c-i2c-device-attr-lm83.patch
> > +gregkh-i2c-i2c-device-attr-lm63.patch
> > +gregkh-i2c-i2c-device-attr-it87.patch
> > +gregkh-i2c-hwmon-01.patch
> > +gregkh-i2c-hwmon-02.patch
> > +gregkh-i2c-hwmon-03.patch
> >
> >  i2c tree updates
> >
> > +i2c-chips-need-hwmon.patch
> > +gregkh-i2c-hwmon-02-sparc64-fix.patch
> >
> >  Fix a few things in the i2c tree
> 
> [snip]
> 
> after those changes i don't get entries in /sys for my W83627THF chip.
> 
> (p4c800-D, i875,ICH5)
> 
> relevant config parts:
> 
> CONFIG_HWMON=y
> CONFIG_I2C=y
> CONFIG_I2C_ISA=y
> CONFIG_I2C_SENSOR=y
> CONFIG_SENSORS_W83627HF=y

Which kernel are you upgrading from?

Is CONFIG_PNPACPI set? If it is, try whithout it.

If it doesn't work, please try reverting (in reverse order):
  gregkh-i2c-hwmon-01.patch
  gregkh-i2c-hwmon-02.patch
  gregkh-i2c-hwmon-03.patch
  i2c-chips-need-hwmon.patch
  gregkh-i2c-hwmon-02-sparc64-fix.patch
and see how it goes.

Thanks,
-- 
Jean Delvare
