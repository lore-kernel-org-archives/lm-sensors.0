From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 16 May 2013 21:56:16 +0000
Subject: [lm-sensors] [PATCH 0/2] Add ds1631 chip support to ds1621 driver
Message-Id: <1368742242-15191-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This set of patches adds ds1631 chip support into the ds1621 driver,
documentation, and Kconfig.

It is based on the 3.9 source base and intended for hwmon-next since it is
dependent on the previously applied ds1721 chip support patch set.

In addition, this code has been tested and validated with the ds1621,
ds1625, ds1721, and ds1631 chips, using sensors, sensors-detect, and
explicit device instantiation

Robert Coulson (2):
  hwmon (ds1621): Add ds1631 chip support to ds1621 driver
  hwmon (ds1621): Add ds1631 information to ds1621 Documentation and
    Kconfig

 Documentation/hwmon/ds1621 |   27 ++++++++++++++++++++++++---
 drivers/hwmon/Kconfig      |    1 +
 drivers/hwmon/ds1621.c     |   27 ++++++++++++++++++++-------
 3 files changed, 45 insertions(+), 10 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
