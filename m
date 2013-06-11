From: Robert Coulson <rob.coulson@gmail.com>
Date: Tue, 11 Jun 2013 01:46:01 +0000
Subject: [lm-sensors] [PATCH 0/2 v2] Add DS1731 chip support and update documentation
Message-Id: <1370915163-30293-1-git-send-email-rob.coulson@gmail.com>
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

v2 - Updated with v1 review comments.

Robert Coulson (2):
  hwmon (ds1621): Add DS1731 chip support to ds1621 driver
  Documentation (hwmon): Update ds1621 device information

 Documentation/hwmon/ds1621 |   95 ++++++++++++++++++++++++++++----------------
 drivers/hwmon/Kconfig      |    1 +
 drivers/hwmon/ds1621.c     |   12 +++---
 3 files changed, 68 insertions(+), 40 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
