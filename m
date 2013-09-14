From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 17:13:41 +0000
Subject: [lm-sensors] [PATCH 00/11] Convert more drivers to use devm_hwmon_device_register_with_groups
Message-Id: <1379178832-1489-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

The jc42 driver is compile tested only. All other patches were tested
with real hardware.

The patches apply on top of the previously submitted patches introducing
hwmon_device_register_with_groups and devm_hwmon_device_register_with_groups.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
