From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Apr 2008 17:41:50 +0000
Subject: [lm-sensors] [PATCH 00/10] Improvements to the lm85 driver
Message-Id: <20080412194150.56a35654@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here's a set of 10 incremental patches fixing, cleaning up and
improving the lm85 hardware monitoring driver. My home server has an
SMSC EMC6D102 chip so I needed the patches for myself, and I tested
them on this machine.

The patches are:
bug fix: [PATCH 01/10] hwmon: (lm85) Fix function RANGE_TO_REG()
cleanup: [PATCH 02/10] hwmon: (lm85) Coding-style cleanups
cleanup: [PATCH 03/10] hwmon: (lm85) Drop dead code
bug fix: [PATCH 04/10] hwmon: (lm85) Don't write back cached values
cleanup: [PATCH 05/10] hwmon: (lm85) Misc cleanups
cleanup: [PATCH 06/10] hwmon: (lm85) Simplify device initialization function
cleanup: [PATCH 07/10] hwmon: (lm85) Rework the device detection
feature: [PATCH 08/10] hwmon: (lm85) Implement the standard PWM frequency interface
feature: [PATCH 09/10] hwmon: (lm85) Select the closest PWM frequency
feature: [PATCH 10/10] hwmon: (lm85) Support different PWM frequency tables

It is worth noting that this shrinks the binary size of the lm85 driver
by 5.5%, and the source code size by 11%.

Comments, reviews and testing are of course welcome.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
