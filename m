From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 31 Mar 2015 16:34:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: (it87) Use feature macros on sio_data
Message-Id: <1427819645-21749-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Feature macros work on sio_data as well, so use them there.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of the previous patch series.

 drivers/hwmon/it87.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index d7935a5e9413..c4cb75cba2f0 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -2047,6 +2047,7 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 	int err;
 	u16 chip_type;
 	const char *board_vendor, *board_name;
+	const struct it87_devices *config;
 
 	err = superio_enter(sioaddr);
 	if (err)
@@ -2131,23 +2132,25 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 		it87_devices[sio_data->type].suffix,
 		*address, sio_data->revision);
 
+	config = &it87_devices[sio_data->type];
+
 	/* in7 (VSB or VCCH5V) is always internal on some chips */
-	if (it87_devices[sio_data->type].features & FEAT_IN7_INTERNAL)
+	if (has_in7_internal(config))
 		sio_data->internal |= (1 << 1);
 
 	/* in8 (Vbat) is always internal */
 	sio_data->internal = (1 << 2);
 
 	/* in9 (AVCC3), always internal if supported */
-	if (it87_devices[sio_data->type].features & FEAT_AVCC3)
+	if (has_avcc3(config))
 		sio_data->internal |= (1 << 3); /* in9 is AVCC */
 	else
 		sio_data->skip_in |= (1 << 9);
 
-	if (!(it87_devices[sio_data->type].features & FEAT_SIX_PWM))
+	if (!has_six_pwm(config))
 		sio_data->skip_pwm |= (1 << 3) | (1 << 4) | (1 << 5);
 
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
