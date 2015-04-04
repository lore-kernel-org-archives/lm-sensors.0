From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:54:51 +0000
Subject: [lm-sensors] [PATCH 00/22] hwmon: (it87) Various enhancements and fixes (take two)
Message-Id: <1428184513-22380-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series builds on top of the already reviewed patches for the
it87 driver. The series was tested on a system with IT8728F.

Some of the patches in this series were previously submitted as part of
the first series. Those patches are marked as v2, with changelog included.

----------------------------------------------------------------
Guenter Roeck (22):
      hwmon: (it87) Fix in7 voltage display
      hwmon: (it87) Use feature macros on sio_data
      hwmon: (it87) Add AVCC3 support for IT8620E
      hwmon: (it87) Add support for all pwm channels on IT8620E
      hwmon: (it87) Add support for second pwm frequency register
      hwmon: (it87) Simplify error return in it87_device_add
      hwmon: (it87) Don't use pdev as static driver variable
      hwmon: (it87) Pass SIO base address as parameter to superio functions
      hwmon: (it87) Add support for second Super-IO chip
      hwmon: (it87) Rearrange code to avoid forward declarations
      hwmon: (it87) Use is_visible for voltage sensors
      hwmon: (it87) Use is_visible for temperature sensors
      hwmon: (it87) Use is_visible for fan attributes
      hwmon: (it87) Use is_visible for pwm attributes
      hwmon: (it87) Use single group and is_visible for miscellaneous attributes
      hwmon: (it87) Convert to use new hwmon API
      hwmon: (it87) Support up to 6 temperature sensors on IT8620E
      hwmon: (it87) Simplify reading voltage registers
      hwmon: (it87) Add support for VIN7 to VIN10 on IT8620E
      hwmon: (it87) Use BIT macro
      hwmon: (it87) Use defines for array sizes and sensor counts
      hwmon: (it87) Formatting cleanup

 drivers/hwmon/it87.c | 1992 ++++++++++++++++++++++++++------------------------
 1 file changed, 1033 insertions(+), 959 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
