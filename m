From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: CPU temp does not update
Message-Id: <5ipw65wb.1106662037.0906340.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


[Please do not forget to CC: the sensors list on reply]

Hi again John,

> > If possible, restart your system so that the w83627hf is not even
> > loaded, in case it had a "permanent" (till next reboot) effect on the
> > chip.
> Not sure how to do this, should I go to all sensors conf files and replace
> w83627hf with w83781d and then reboot ?

Simply edit /etc/rc.d/rc.local, replace "modprobe w83627hf" with
"modprobe w83781d". Even better, comment out the modprobe line
altogether, so that you can load the drivers manually for now. Remove
the call to "sensors -s" if you do.

> temp2:     +25.5?C  (high =   +52?C, hyst =   +47?C)   sensor = thermistor
> (...)
> isadump 0x295 0x296 1
> (...)
> 50: 19 80 01 2f 00 34 00 ff ff ff ff ff ff ff ff ff

The register values match what was displayed by "sensors". However,
configuration register (at 0x52) reads 0x01 which means (surprise)
"stop monitoring". This explains why the value is never updated.

The w83781d driver in lm_sensors 2.7.0 explicitely re-enables temp2 and
temp3, which is why it works fine on your Mandrake 9.1 system. The
w83781d driver in Linux 2.6 re-enables temp3 but for some reason not
temp2. Don't even bother testing it, it will not behave any better than
w83627hf does. The w83627hf driver in Linux 2.6 doesn't re-enable any
of them, thus the problem you observed.

I would like you to dump the chip again (with "isadump 0x295 0x296 1")
after a reboot but before you load any chip driver (this supposes that
you commented out the modprobe line in /etc/rc.d/rc.local as explained
above). That way we will know what state the chip is in in the first
place. The datasheet says that temp2 and temp3 are enabled by default,
but I start doubting that.

Then you may try loading the w83627hf driver with the init parameter set
to 0:
modprobe w83627hf init=0
Among others, it will skip the chip reset. I have been advocating a
removal of chip resets from all drivers for a long time now, BTW.

Let us know if temp2 now updates properly or not.

If it does, you may want to add the following line to /etc/modprobe.conf:
options w83627hf init=0
That would solve your problem for now.

Nevertheless, we obviously need to fix the Linux 2.6 drivers so that they
re-enable temp2 and temp3 again.

Thanks,
--
Jean Delvare
