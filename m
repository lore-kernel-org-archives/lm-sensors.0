From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 28 May 2013 23:56:00 +0000
Subject: [lm-sensors] [PATCH 0/2] Add DS1731 chip support and update documentation
Message-Id: <1369785362-19133-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch set was tested with a DS1731 device, is based on 3.9 sources,
and is intended for the hwmon-next branch (since it leverages previous
ds1621 committed patches).

The first patch adds support for the DS1731 chip in the ds1621 driver,
Kconfig, and documentation.

The second patch is an update for the ds1621 documention that provides
better clarity of each chip type.

Robert Coulson (2):
  hwmon (ds1621): Add DS1731 chip support to ds1621 driver
  hwmon (ds1621): Update ds1621 device information

 Documentation/hwmon/ds1621 |   86 +++++++++++++++++++++++++-------------------
 drivers/hwmon/Kconfig      |    1 +
 drivers/hwmon/ds1621.c     |   12 ++++---
 3 files changed, 57 insertions(+), 42 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
