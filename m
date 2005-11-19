From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 19 Nov 2005 19:53:04 +0000
Subject: [lm-sensors] VT8231 testers wanted
Message-Id: <20051119195336.2a71bd94.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

We almost have a working and acceptable vt8231 port to Linux 2.6.
Thanks to Aaron Marsh for porting the driver originally and to Roger
Lucas for polishing it until I could accept it into Linux 2.6.

I am now looking for testers. Roger and I made many significant changes
to the driver while porting it, the 2.6 version of the driver is
actually more of a rewrite than a port. libsensors and sensors received
their load of updates to adapt to the changes, and I had to update the
lm_sensors (2.4) version of the vt8231 driver as well so that
libsensors could possibly support both drivers with the same
configuration file. I would now like to make sure that the 2.6 driver
works OK and that the 2.4 driver wasn't broken in the process.

In order to test the 2.4 driver, you must get lm_sensors CVS:
  http://secure.netroedge.com/~lm78/download.html#cvs
It should work OK with any version of i2c >= 2.9.0.

In order to test the 2.6 driver you also need to get lm_sensors CVS for
the user-space part. The driver itself is available as a patch which
should apply to linux-2.6.15-rc1 or later just fine:
  http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt8231-new-driver.patch

Make sure you pick etc/sensors.conf.eg in both cases. It has a new
section dedicated to the vt8231 driver, which includes all the required
changes for the new drivers.

For the 2.4 driver, I am particularly interested in feedback about the
VID and PWM features. Roger noticed that the VT8231 datasheet doesn't
mention these, so the 2.6 driver doesn't include them. If nobody got
these working with the 2.4 driver, we may drop them there too, and in
libsensors as well.

If anyone is up to review the code changes (both the new driver and the
recent changes in lm_sensors CVS) they are more than welcome to do so.

Thanks,
-- 
Jean Delvare
