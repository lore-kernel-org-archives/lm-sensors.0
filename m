From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 24 Jun 2007 16:14:39 +0000
Subject: [lm-sensors] kernel TODO
Message-Id: <20070624161439.GD3289@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

Here's a list of kernel patches (oldest first) which are not in my queue[1] and
their status.  If your patch is not in my queue *and* it is missing from this
list, please resend it to me + CC the list.  Note that I'm asking for the oldest
patches to be updated and resent anyway.

Some of these patches need a primary reviewer.

Let me know what I missed, status updates, etc.  Thanks!

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

[PATCH] THMC50 and ADM1022 support for 2.6 kernel (improved)
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019094.html
status: update & resend, please

[Patch] Add Fintek F75375S driver
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019107.html
status: update & resend, please

[PATCH] Apple SMC driver - fix input device
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019462.html
status: update & resend, please

[PATCH 1/2] Apple SMC driver - standardize and sanitize sysfs tree + minor features addition
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019519.html
[PATCH 2/2] Apple SMC driver - implement key enumeration
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019520.html
status: update & resend, please

[PATCH] Add LM93 support
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019526.html
status: reviewed, waiting for update
reviewer: Mark M. Hoffman

[PATCH] applesmc - switch to using input-polldev
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019787.html
status: needs respin to v2.6.22-rc5, wants to be picked for testing

[PATCH] ams - switch to using input-polldev
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019788.html
status: wants reviewer

[ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020003.html
status: wants reviewer

PATCH: hwmon-abituguru3-new-driver.patch: Add support for newer uGuru's
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020036.html
status: wants to be picked for testing
reviewer: Juerg Haefliger

[PATCH] Add temperature-tracking mode to f71805f driver (v2)
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020079.html
status: reviewed by Jean Delvare, needs update for email addresses

[PATCH] hwmon/smsc47b397: Don't report missing fans as spinning at 82 RPM
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020106.html
status: wants to be picked for testing

[PATCH 00/10] hwmon/w83627ehf: Fixes and new features
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020112.html
status: wants reviewer

Thanks & regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
