From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 15 Mar 2012 11:59:14 +0000
Subject: [lm-sensors] Watchdog timer core enhancements
Message-Id: <1331812757-3491-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-watchdog@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

Hi,

Short selfintro for the watchdog people: I'm a FOSS developer / enthusiast
for close to 15 years now. I've written Linux kernel drivers for a ton
of webcams and various hwmon IC's.

Three of the hwmon drivers I maintain are IC's which also include a watchdog
part in their hwmon solution.

This is a resend of a series of watchdog_dev patches which I initially send
on Sep 12 2011:
http://lists.lm-sensors.org/pipermail/lm-sensors/2011-September/033707.html
And which unfortunately has seen 0 reviews / feedback since then.

This resend is re-based on top of v3.3-rc7

Currently the hwmon drivers I maintain are implementing the watchdog API
all by themselves, I would very much like to switch them over to
watchdog_dev to remove a lot of code duplication, but there currently
are 2 things stopping me from moving them over:

1) The driver core only works for 1 watchdog, but both my fschmd and my sch5636
test systems also have an iTCO watchdog and that tends to load first. Thus when
writing the fschmd watchdog code I made it support loading either on the
default watchdog minor, or on one of the additional reserved watchdog minors
(212-215). The first patch in this series adds support for this to the
watchdog timer driver core (which was quite straightforward to add).

2) Most Linux drivers use dynamically allocated memory for the driver data,
which gets allocated on calling the probe function and released on driver
unbind. This means that merely locking the module containing the driver as long
as /dev/watchdog is open is not sufficient, since the driver can still be
unbound. The second patch in this series fixes this.

Note that the 2nd issue is also hit by the recently posted:
"[PATCH V2 00/22] watchdog: ARM watchdogs: sp805 & mpcore updates & fixes"
patch series which convert the mpcore_wdt driver to watchdog_dev, doing
an unbind between the platform driver and the platform dev there from sysfs
while an app holds the /dev/watchdog file open will make file->private_data
for that file handle point to freed memory!

Once this series is upstream I'll also write a patches to convert all my
hwmon IC with watchdog watchdog driver parts to watchdog_dev.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
