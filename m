From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Wed, 10 Sep 2008 09:27:31 +0000
Subject: [lm-sensors] [patch 2.6.27-rc6] hwmon/pc87360 separate sysfs _alarm
Message-Id: <cfe85dfa0809100227y74316c11h90438e744151268a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From a480ee948637091b98d73f77da6aad3ed17ba165 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 10 Sep 2008 03:17:49 -0600
Subject: [PATCH] hwmon/pc87360 separate sysfs alarm files

Bring hwmon/pc87360 into agreement with Documentation/hwmon/sysfs-interface

Patchset adds separate limit alarms for voltages and temps, it also adds
temp[123]_fault files.  On my Soekris, temps 1,2 are unused/unconnected,
so temp[123]_fault = 1,1,0 respectively.  This agrees with /usr/bin/sensors,
which has always shown them as OPEN.  Temps 4,5,6 are thermistor based,
and dont have a fault bit in their status register.


Jim Cromie (6):
  hwmon/pc87360 separate alarm files - define some constants
  hwmon/pc87360 separate alarm files - add in-min/max-alarms
  hwmon/pc87360 separate alarm files - add
    temp-min/max/crit/fault-alarms
  hwmon/pc87360 separate alarm files - define LDNI_MAX const
  hwmon/pc87360 separate alarm files - add dev_dbg help
  hwmon/pc87360 separate alarm files - add therm-min/max/crit-alarms

 drivers/hwmon/pc87360.c |  244 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 223 insertions(+), 21 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
