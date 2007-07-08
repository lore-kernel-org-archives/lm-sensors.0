From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jul 2007 18:14:11 +0000
Subject: [lm-sensors] kernel TODO 20070708
Message-Id: <20070708181411.GE3584@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

Here's a list of kernel patches (oldest first) which are not in my queue[1] and
their status.  If your patch is not in my queue *and* it is missing from this
list, please resend it to me + CC the list.

Some of these patches need a primary reviewer - if nobody else steps up, I will
chew through them in (roughly) FIFO order.

Also FYI: I will be on vacation without email access July 9th-16th.  If you find
some ultra-critical must-get-in-before-2.6.22 thing during that time, please send
it to Jean Delvare <khali@linux-fr.org>.

Let me know what I missed, status updates, etc.  Thanks!

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

[PATCH] THMC50 support for 2.6 (3rd revision)
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020310.html
status: reviewed, needs (probably) one last revision
reviewers: Mark M. Hoffman, Jean Delvare

[PATCH] Add f75375s driver
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020190.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020308.html
status: has tester = good, still wants reviewer

[PATCH] Apple SMC driver - fix input device
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019462.html
status: not sure it belongs in my tree, will deal with it later

[PATCH] applesmc - switch to using input-polldev
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019787.html
status: not sure it belongs in my tree, will deal with it later

[PATCH] ams - switch to using input-polldev
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-May/019788.html
status: not sure it belongs in my tree, will deal with it later

[ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020003.html
status: wants reviewer

[PATCH] applesmc - add temperature sensors set for Macbook
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020204.html
status: wants reviewer

PATCH: hwmon-fscpos-individual-alarm-files-v2.patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020253.html
status: wants reviewer

[PATCH 0/5] hwmon/lm85: Fixes and improvements
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020275.html
status: wants reviewer

PATCH: hwmon-f71882fg-new-driver.patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020297.html
status: wants reviewer

PATCH:  hwmon-fscher-individual-alarm-files-v3.patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html
status: wants reviewer

[PATCH] hwmon/it87: Add support for fan4 and fan5
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020303.html
status: wants reviewer

[PATCH] First cut of a adt7470 driver
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020312.html
status: reviewed, wants updated
reviewer: Hans de Goede

[ patch ]  de-macro-fy w83627hf.c
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020340.html
status: wants reviewer

[PATCH] adm1021 dynamic sysfs callbacks added
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020344.html
status: wants reviewer

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
