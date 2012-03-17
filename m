From: Hans de Goede <hdegoede@redhat.com>
Date: Sat, 17 Mar 2012 09:40:28 +0000
Subject: [lm-sensors] [PATCH 0/1] hwmon/sch56xx: Add support for the integrated watchdog
Message-Id: <1331977229-1370-1-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <lm-sensors@lm-sensors.org>
Cc: linux-watchdog@vger.kernel.org, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>

Hi All,

The single patch in this series adds support for the watchdog integrated into
the SMSC SCH5627 and SCH5636 superio-s. Since the watchdog is part of the
hwmon logical device and thus shares ioports with it, the watchdog driver is
integrated into the existing hwmon drivers for these.

As such I think it is best if this patch gets merged through the hwmon tree.

Note that this version of the watchdog support for sch56xx superio-s
implements the watchdog chardev interface itself, rather then relying on
the recently added watchdog core / watchdog_dev. The code for this was
lifted (almosy) 1 on 1 from the fschmd which has a watchdog driver integrated
in a similar fashion.

This is done because currently some needed functionality is missing from
watchdog_dev, as soon as this functionality is added (which is being discussed
on the linux-watchdog mailinglist), I'll convert this driver over to using
watchdog_dev.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
