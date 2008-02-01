From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 13:08:12 +0000
Subject: [lm-sensors] hwmon/kernel TODO (was Re: [PATCH] hwmon/dme1737: fix
Message-Id: <20080201130812.GH20687@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg:

* Juerg Haefliger <juergh@gmail.com> [2008-01-31 22:56:56 -0800]:
> Jeez, I'm definitely too slow :-) Mark, do you keep a list of patches
> awaiting review?

(:r ~/src/hwmon/HWMON-TODO)

Here's a list of kernel patches (oldest first) which are not in my queue[1] and
their status.  If your patch is not in my queue *and* it is missing from this
list, please resend it to me + CC the list.

Some of these patches need a primary reviewer - if nobody else steps up, I will
chew through them in (roughly) FIFO order.

Let me know what I missed, status updates, etc.  Thanks!

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

[ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020003.html
status: wants more discussion

[ patch .24-rc0 0/5 ] SuperIO locks coordinator
status: wants reviewer

[patch 2.6.23-rc8 1/3] lm75: cleanups (no functional changes)
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021269.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021303.html
status: reviewed by Jean, updated, needs Ack

[patch 2.6.23-rc8 2/3] lm75: new style driver binding
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021270.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021305.html
status: reviewed by Jean, updated, needs more work?

[patch 2.6.23-rc8 3/3] lm75: use 12 bit samples
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021271.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021308.html
status: reviewed by Jean, updated, needs more work?

[PATCH] hwmon: add support for GMT G760A fan speed PWM controller
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021919.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-November/021986.html
status: reviewed by Jean, needs updated

[PATCH] coretemp: Add TEMP_TARGET support
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022071.html
status: reviewed by Jean, needs updated

asm58 for 2.10.0, linux 2.6.15
http://lists.lm-sensors.org/pipermail/lm-sensors/2006-March/015735.html
status: needs updated

adt7473: New driver for Analog Devices ADT7473 sensor chip
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022202.html
status: wants reviewer

hwmon: (lm92) Add individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022275.html
status: wants reviewer

hwmon: (max1619) Add individual alarm and fault files
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022276.html
status: wants reviewer

hwmon: (smsc47m1) Add individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022277.html
status: wants reviewer

hwmon: (via686a) Add individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022278.html
status: wants reviewer

hwmon: (vt8231) Add individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022279.html
status: tested, wants quick review before merge

ad7414 driver
(CC'ed to linuxppc-dev@ozlabs.org)
status: wants reviewer

coretemp: Add maximum cooling temperature readout
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022321.html
coretemp: Add TjMax detection for mobile CPUs
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022322.html
coretemp: Add Penryn CPU to coretemp
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022323.html
status: wants reviewer

[PATCH 1/2] hwmon: Define sysfs interface for energy consumption register
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022367.html
[PATCH 2/2] ibmpex: Add energy consumption meters
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-January/022365.html
status: wants review/discussion

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
