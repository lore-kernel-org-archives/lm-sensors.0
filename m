From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: lm87 ported to Linux 2.6
Message-Id: <20040823215206.0609831f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After some time, we finally have a first candidate patch for a lm87
driver in Linux 2.6. I started from what David sent to me a few days
ago, which I guess is Jeff's work? I reviewed it, reworked it
significantly to comply better with the latest standards of the Linux
2.6 i2c subsystem, fixed a few things and here we are.

First of all, I'd like to thank you all for your interest in the lm87
driver, and hope we'll come to something acceptable to be submitted to
Greg soon now.

The patch is available here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/linux-2.6.8.1-mm4-i2c-lm87-alpha1.diff
It should apply and work on linux-2.6.8.1-mm1, -mm2, -mm3 and -mm4
kernels.

Please let me know who exactly contributed to the patch I started from,
so that everyone gets credited as he deserves.

Please note that the driver will check that it is called on a
hardware-monitoring classed bus. Make sure the i2c adapter you use
declares itself with .class=I2C_CLASS_HWMON. If not, either change that
(and report if the bus driver is already in the 2.6 kernel tree) or skip
the test in lm87_attach_adapter for now.

This first patch is untested beyond compilation, as I don't own a LM87
myself. This is why I rely on you for testing. The more testers there
are, the faster it'll be to get the driver into Greg's tree. Please test
and report how it is working for you. The latest libsensors/sensors from
lm_sensors CVS are mandatory (> July 7th, today prefered), unless you
test the sysfs interface directly, which would be nice as well BTW.

I'd also be interested by i2cdumps of your LM87s. The detection of the
LM87 is probably correct but could be refined so as to prevent any
misdetection.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
