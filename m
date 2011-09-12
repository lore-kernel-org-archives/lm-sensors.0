From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Sep 2011 09:56:55 +0000
Subject: [lm-sensors] Watchdog timer core enhancements + sch5636 watchdog
Message-Id: <1315821420-16205-1-git-send-email-hdegoede@redhat.com>
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

Two of the hwmon drivers I maintain are for Fujitsu manufacturered IC's which
include a watchdog part in their hwmon solution. The fschmd driver for their
family of i2c hwmon IC's already supports this using the standard watchdog API.

While waiting for some input from Fujitsu needed to get the watchdog in their
new SMSC SCH5636 superio (with a programmable micro controller) based hwmon
solution working, I read the announcement of the watchdog timer driver core.

I'm really happy to see the watchdog timer driver core, as I just copy and
pasted a whole bunch of code from the fschmd driver to the sch5636 driver,
having a standard watchdog core definitely is a good idea.

So when working on finishing up my watchdog support for the sch5636 driver
I decided to convert it to the new watchdog timer driver core.

I hit 2 issues during this (and 2 minor others):
1) The driver core only works for 1 watchdog, but both my fschmd and my sch5636
test systems also have an iTCO watchdog and that tends to load first. Thus when
writing the fschmd watchdog code I made it support loading either on the
default watchdog minor, or on one of the additional reserved watchdog minors
(212-215). The second patch in this series adds support for this to the
watchdog timer driver core (which was quite straightforward to add).

2) Most Linux drivers use dynamically allocated memory for the driver data,
which gets allocated on calling the probe function and released on driver
unbind. This means that merely locking the module containing the driver as long
as /dev/watchdog is open is not sufficient, since the driver can still be
unbound. The third patch in this series fixes this.

The other 2 patches to the watchdog core fix 2 minor issues and are self
explanatory. The 5th patch in the series adds support for the integrated
watchdog to the sch5636 driver. It seems this will be the first driver
actually using the new core :)

I think it is best for this entire series to go in through the watchdog tree,
since the 5th patch depends on the others (even though the 5th patch touches
hwmon code).

Once this is upstream I'll also write a patch to convert the fschmd driver to
use the watchdog core, and maybe also the iTCO driver.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
