From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 15 Feb 2006 11:41:37 +0000
Subject: [lm-sensors] w83781d and empty /sys/class/hwmon
Message-Id: <6wEGnqlQ.1140003697.4831800.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
In-Reply-To: <030d01c63220$60c0ace0$5964a8c0@office.aradio.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > But directory /sys/class/hwmon is empty, and sensors -s does not
> > > work!
> >
> > Does the device show under /sys/bus/i2c/devices?
>
> /sys/bus/i2c/devices is empty too

OK, so the problem you have is not related to the hwmon class code. The
I2C chip was not properly detected in the first place.

> but there is simlink to device in /sys/class/i2c-dev/i2c-0

This means that the bus driver (i2c-piix4) works. This doesn't mean that
any device on that bus was properly recognized.

> > Does "sensors" (without -s) work?
>
> no, it does not (strace shows it tries to read /sys/class/hwmon and exits
> with error)

This is expected if the hardware monitoring device wasn't properly
detected.

Which version of lm_sensors are you using?

Which motherboard is this?

Any message in the logs when loading the w83781d driver?

Pleas provide the output of:
  i2cdump 0 0x2d b

Thanks,
--
Jean Delvare

