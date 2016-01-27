From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
Date: Wed, 27 Jan 2016 02:03:46 +0000
Subject: [lm-sensors] [PATCH v3 22/25] hwmon: (it87) Enhance validation for fan4 and fan5
Message-Id: <1453860229-23614-23-git-send-email-patchwork@patchwork.roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Several of the chips supported by this driver have a configuration
register to enable fan4 and fan5. Use those registers to determine
if fan4 and fan5 tachometers are supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index f40d81a0a9fc..5adb269918fb 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -2415,6 +2415,29 @@ static int __init it87_find(int sioaddr, unsigned short *address,
 
 		superio_select(sioaddr, GPIO);
 
+		/* Check for fan4, fan5 */
+		if (has_five_fans(config)) {
+			reg = superio_inb(sioaddr, IT87_SIO_GPIO2_REG);
+			switch (sio_data->type) {
+			case it8718:
+				if (reg & BIT(5))
+					sio_data->skip_fan |= BIT(3);
+				if (reg & BIT(4))
+					sio_data->skip_fan |= BIT(4);
+				break;
+			case it8720:
+			case it8721:
+			case it8728:
+				if (!(reg & BIT(5)))
+					sio_data->skip_fan |= BIT(3);
+				if (!(reg & BIT(4)))
+					sio_data->skip_fan |= BIT(4);
+				break;
+			default:
+				break;
+			}
+		}
+
 		reg = superio_inb(sioaddr, IT87_SIO_GPIO3_REG);
 		if (!sio_data->skip_vid) {
 			/* We need at least 4 VID pins */
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
