From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 24 Nov 2007 14:34:09 +0000
Subject: [lm-sensors] lm-sensors 3.0.0 has been released!
Message-Id: <20071124153409.6e644e9f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

After over 7 months of work and 3 release candidates, lm-sensors 3.0.0
is finally there!

Important changes compared to lm-sensors 2.10:
* lm-sensors 3 only supports kernels 2.6.5 and later.
* It is now a user-space-only package, it no longer contains kernel
  drivers.
* The i2c tools have been moved to a separate package (surprisingly
  named i2c-tools).
* libsensors' internal version was bumped to 4.0.0, as it has a
  completely new API we had to increase the .so version. This new
  library contains no chip-specific knowledge, it assumes that hardware
  monitoring drivers follow the standard sysfs interface. A very nice
  benefit of this is that the size of the library has been divided by
  4 (down from 222 kB to 55 kB on i386).
* sensors.conf is not fully compatible between the old and the new
  library. The lm-sensors 3 package includes a conversion script
  from the old format to the new one.
* Some kernel drivers still don't implement the standard interface
  for alarms, so alarm flags won't show.

I would like to thank Hans de Goede and his students for contributing
the initial rewrite of libsensors, which made it all possible.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
