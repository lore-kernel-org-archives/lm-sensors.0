From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Sep 2007 16:21:46 +0000
Subject: [lm-sensors] kernel TODO 20070909
Message-Id: <20070909162146.GA31999@jupiter.solarsys.private>
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

Let me know what I missed, status updates, etc.  Thanks!

[1] http://lm-sensors.org/kernel?p=kernel/mhoffman/hwmon-2.6.git;a=shortlog;h=testing

[ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-June/020003.html
status: wants more discussion

PATCH:  hwmon-fscher-individual-alarm-files-v3.patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020301.html
status: wants reviewer

[ patch ]  de-macro-fy w83627hf.c
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020340.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020417.html
status: reviewed, wants updated
reviewers: Jean Delvare & Krzysztof Helt

[PATCH] adm1021 dynamic sysfs callbacks added
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020344.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021107.html
status: reviewed, updated, wants ack'ed
reviewer: Jean Delvare

PATCH: hwmon-fscher-support-fscpos.patch
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020386.html
status: reviewed, wants updated(?)
reviewer: Jean Delvare

[PATCH] adm1021: dynamic sysfs callbacks conversion
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020593.html
status: reviewed, wants updated
reviewer: Jean Delvare

[PATCH 1/3] hwmon/dme1737: cleanups
[PATCH 2/3] hwmon/dme1737: group functions logically
[PATCH 3/3] hwmon/dme1737: add sch311x support
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021053.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021054.html
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021082.html
status: reviewed, wants updated (1 & 3)
reviewer: Jean Delvare

[PATCH] v3 of IBM power meter driver
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021084.html
status: wants reviewer

[PATCH] hwmon: Add power meters to Documentation/hwmon/sysfs-interface
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021079.html
status: there was some discussion, probably wants updated

[PATCH] hwmon: Kconfig dependency cleanups
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-August/021089.html
status: wants reviewer

[PATCH] Driver for Winbond W83L786NG/NR
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021108.html
status: wants reviewer

[PATCH] hwmon/lm78: Add individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021151.html
status: wants reviewer

[PATCH] hwmon/lm90: Export temperature offset values
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021154.html
status: wants reviewer

[PATCH] adm1021: individual alarm files
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021177.html
status: wants reviewer

[PATCH] thmc50: fixed alarms clearing
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-September/021186.html
status: wants reviewer

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
