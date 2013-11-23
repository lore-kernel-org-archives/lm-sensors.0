From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 19:03:16 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon updates for x86 platform drivers
Message-Id: <1385233401-21517-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: Corentin Chary <corentin.chary@gmail.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, acpi4asus-user@lists.sourceforge.net, platform-driver-x86@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Common changes:
- Convert to new hwmon API to simplify code and avoid race conditions
  due to late sysfs attribute registration.
  With this change, hwmon sysfs attributes are now always attached
  to the hwmon device and no longer to its parent device (where this
  was the case).
- Replace SENSOR_DEVICE_ATTR with DEVICE_ATTR where appropriate,
  ie if the additional parameter provided by SENSOR_DEVICE_ATTR
  was not used.
- Use devm_kzalloc() instead of kzalloc() where appropriate to reduce
  code size and simplify error path.

All patches were compile tested only. Unfortunately, I don't have
the necessary hardware to test on real systems.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
