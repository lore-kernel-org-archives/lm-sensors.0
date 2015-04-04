From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:54:53 +0000
Subject: [lm-sensors] [PATCH 02/22] hwmon: (it87) Use feature macros on sio_data
Message-Id: <1428184513-22380-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Feature macros work on sio_data as well, so use them there.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 32180aaa4ac6..04b929cc21f3 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -1821,6 +1821,7 @@ static int __init it87_find(unsigned short *address,
 	int err;
 	u16 chip_type;
 	const char *board_vendor, *board_name;
+	const struct it87_devices *config;
 
 	err = superio_enter();
 	if (err)
@@ -1905,8 +1906,10 @@ static int __init it87_find(unsigned short *address,
 		it87_devices[sio_data->type].suffix,
 		*address, sio_data->revision);
 
+	config = &it87_devices[sio_data->type];
+
 	/* in7 (VSB or VCCH5V) is always internal on some chips */
-	if (it87_devices[sio_data->type].features & FEAT_IN7_INTERNAL)
+	if (has_in7_internal(config))
 		sio_data->internal |= (1 << 1);
 
 	/* in8 (Vbat) is always internal */
@@ -1916,7 +1919,7 @@ static int __init it87_find(unsigned short *address,
 	if (sio_data->type != it8603)
 		sio_data->skip_in |= (1 << 9);
 
-	if (!(it87_devices[sio_data->type].features & FEAT_VID))
+	if (!has_vid(config))
 		sio_data->skip_vid = 1;
 
 	/* Read GPIO config and VID value from LDN 7 (GPIO) */
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
