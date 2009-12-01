From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 01 Dec 2009 08:33:37 +0000
Subject: [lm-sensors] [PATCH v4 0/5] LIS3 feature update
Message-Id: <1259656422-7697-1-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Samu Onkalo <samu.p.onkalo@nokia.com>

Changes since v3 patch set:

0001: two if statements combined to one

0002: added "Acked by Eric Piel" to description

0003: Replaced with edited version by Eric Piel. Tested on 8 bit device
by me.

0004: Constant names changed to shorter ones. Shorter names allowed some clean
up. No functional changes

0005: added "Acked by Eric Piel" to description

Description from version 3 patch set:

This patch set is made to top of 7 previously accepted lis3 related patches in
mm-tree:
- I2C bus support for lis3lv02d and variant accelerometer chips...
- Add the possibility to remap axes via platform data...
- Send input_sync after each measurement round...
- polled input device itself was not free'd....
- riginally the driver was only targeted to 12bits sensors...
- Most of the documentation and comments were written when the driver ..
- Lis3 accelerometer sensors have quite long power on delay ..

Tested with 2.6.32-RC7 which was patched with above 7 lis3 related patches.
Tested only with 8 bit lis3 device since I don't have possibility to test other chips.

0001:
Implement selftest feature for HW diagnostic purposes. This feature can be used to detect if the sensor is electrically or mechanically damaged.

0002:
Calibration functionality is removed from the driver. Chip is allready calibrated by the manufacturer. SW calibration doesn't improve the situation.

0003:
Added possibility to set chip sampling rate. Position entry in sysfs allows reading at sampling rate.

0004:
Scale output values to mg (1/1000 of earth gravity).
Behaviour of the joystick interface is not changed. All other interfaces will have different scale after this patch. See further information from patch itself.

0005:
Update documentation to cover changes which were made by these patches.

Samu Onkalo (5):
  lis3: Selftest support
  LIS3LV02D: Remove calibaration functionality
  lis3: Sysfs entry for setting chip measurement rate
  lis3: Scale output values to mg
  LIS3: Update documentation to match latest changes

 Documentation/hwmon/lis3lv02d |   31 ++++++--
 drivers/hwmon/lis3lv02d.c     |  174 ++++++++++++++++++++++++++++++++---------
 drivers/hwmon/lis3lv02d.h     |   23 ++++-
 include/linux/lis3lv02d.h     |    3 +
 4 files changed, 182 insertions(+), 49 deletions(-)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
