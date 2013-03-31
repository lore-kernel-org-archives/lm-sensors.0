From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 31 Mar 2013 18:09:34 +0000
Subject: [lm-sensors] [PATCH 0/5] hwmon: (it87) Convert driver to use is_visible
Message-Id: <1364753379-20222-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch series reduces object size by about 1,400 bytes on x86_64.
Tested with IT8728.

----------------------------------------------------------------

Guenter Roeck (5):
hwmon: (it87) Use is_visible for voltage sensors
hwmon: (it87) Use is_visible for temperature sensors
hwmon: (it87) Use is_visible for fan attributes
hwmon: (it87) Use is_visible for pwm attributes
hwmon: (it87) Use single group for miscellaneous attributes

drivers/hwmon/it87.c |  479 ++++++++++++++++++++------------------------------
1 file changed, 190 insertions(+), 289 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
