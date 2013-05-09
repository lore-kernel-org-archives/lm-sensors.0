From: Robert Coulson <rob.coulson@gmail.com>
Date: Thu, 09 May 2013 05:45:52 +0000
Subject: [lm-sensors] [lm-sensors 0/2] hwmon: add ds1721 chip support
Message-Id: <1368078354-26298-1-git-send-email-rob.coulson@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

this patch series is targeted for the 3.9 branch and contains these patches:
- 1/2: ds1721 chip support to the ds1621 driver.
- 2/2: ds1721 conversion interval attribute support.

These patches did not have any checkpatch errors or warnings and have been
tested with ds1621, ds1625, and ds1721 chips.

Please review them and provide your comments.

Regards,
Rob

Robert Coulson (2):
  hwmon: (ds1621) Add ds1721 chip support
  hwmon: (ds1621) Add ds1721 update interval sysfs attribute

 Documentation/hwmon/ds1621 |   91 ++++++++++++++++++++--
 drivers/hwmon/Kconfig      |    9 ++-
 drivers/hwmon/ds1621.c     |  178 ++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 255 insertions(+), 23 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
