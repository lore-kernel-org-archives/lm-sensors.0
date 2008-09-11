From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 04:24:20 +0000
Subject: [lm-sensors] [ patch 2.6.27-rc6 0/6 v2] separate alarm sysfs files
Message-Id: <cfe85dfa0809102124vcb08986le95ef914ba2d41b2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From 7b4b599eef53f06825dbd2337714f028a0516069 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 10 Sep 2008 21:49:53 -0600
Subject: [PATCH] hwmon/pc87360 separate sysfs alarm files

Bring hwmon/pc87360 into agreement with Documentation/hwmon/sysfs-interface

Patchset adds separate limit alarms for voltages and temps, it also adds
temp*_fault files.  On my Soekris, temps 1,2 are unused/unconnected,
so temp[123]_fault = 1,1,0 respectively.  This agrees with /usr/bin/sensors,
which has always shown them as OPEN.

This respin fixes style nits noted on lm-sensors ML

Jim Cromie (6):
  hwmon/pc87360 separate alarm files - define some constants
  hwmon/pc87360 separate alarm files - add in-min/max-alarms
  hwmon/pc87360 separate alarm files - add
    temp-min/max/crit/fault-alarms
  hwmon/pc87360 separate alarm files - use ARRAY_SIZE, not 3
  hwmon/pc87360 separate alarm files - add dev_dbg help
  hwmon/pc87360 separate alarm files - add therm-min/max/crit-alarms

 drivers/hwmon/pc87360.c |  251 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 230 insertions(+), 21 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
