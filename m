From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Date: Sat, 27 Jun 2015 13:22:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (dell-smm-hwon) Use a valid name attribute
Message-Id: <1435411325-27428-1-git-send-email-gabriele.mzt@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: pali.rohar@gmail.com, linux@roeck-us.net, jdelvare@suse.de
Cc: gregkh@linuxfoundation.org, arnd@arndb.de, stevenhoneyman@gmail.com, Valdis.Kletnieks@vt.edu, jochen@penguin-breeder.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>

As per Documentation/hwmon/sysfs-interface, hwmon name attributes must
not include '-', so replace 'dell-smm' with 'dell_smm'.

Fixes: 039ae58503f3 ("hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k")
Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/hwmon/dell-smm-hwmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/dell-smm-hwmon.c b/drivers/hwmon/dell-smm-hwmon.c
index 2a80882..37c16af 100644
--- a/drivers/hwmon/dell-smm-hwmon.c
+++ b/drivers/hwmon/dell-smm-hwmon.c
@@ -777,7 +777,7 @@ static int __init i8k_init_hwmon(void)
 	if (err >= 0)
 		i8k_hwmon_flags |= I8K_HWMON_HAVE_FAN2;
 
-	i8k_hwmon_dev = hwmon_device_register_with_groups(NULL, "dell-smm",
+	i8k_hwmon_dev = hwmon_device_register_with_groups(NULL, "dell_smm",
 							  NULL, i8k_groups);
 	if (IS_ERR(i8k_hwmon_dev)) {
 		err = PTR_ERR(i8k_hwmon_dev);
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
