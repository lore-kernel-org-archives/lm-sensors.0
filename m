From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 15 Apr 2007 16:13:02 +0000
Subject: [lm-sensors] kernel/hwmon todo
Message-Id: <20070415161302.GB3158@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi everyone:

Here's a list of kernel patches which are not in Jean's queue[1] and which need
review.  I've only searched the mailing list archives back through March.  I'm
sure I've missed some, or if there are updated patches available for any of
these, please let me know.

Also, some of these patches need a primary reviewer.

[1] http://khali.linux-fr.org/devel/linux-2.6/jdelvare-hwmon/

[PATCH 1/2 RESEND] hwmon: new driver for SMSC DME1737
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019298.html
[PATCH 2/2 RESEND] hwmon: documentation for new SMSC DME1737 driver
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019299.html
primary reviewer: Hans de Goede

PATCH: hwmon-abituguru3-new-driver.patch: Add support for newer uGuru's
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019433.html
primary reviewer: Juerg Haefliger

[PATCH] Apple SMC driver - fix input device
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019462.html

[PATCH 1/2] Apple SMC driver - standardize and sanitize sysfs tree + minor features addition
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019519.html
[PATCH 2/2] Apple SMC driver - implement key enumeration
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019520.html

[PATCH] Add LM93 support
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019526.html
primary reviewer: mmh

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
