From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Kill another macro abuse in via686a
Message-Id: <20050517223857.531710cd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

This patch kills another macro abuse in the via686a hardware monitoring
driver. Using a macro just to alias an array is quite useless, isn't it?

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/i2c/chips/via686a.c |   23 ++++++++++-------------
 1 files changed, 10 insertions(+), 13 deletions(-)

--- linux-2.6.12-rc4.orig/drivers/i2c/chips/via686a.c	2005-05-16 22:51:53.000000000 +0200
+++ linux-2.6.12-rc4/drivers/i2c/chips/via686a.c	2005-05-17 22:29:06.000000000 +0200
@@ -78,15 +78,10 @@
 #define VIA686A_REG_FAN_MIN(nr)	(0x3a + (nr))
 #define VIA686A_REG_FAN(nr)	(0x28 + (nr))
 
-/* the following values are as speced by VIA: */
-static const u8 regtemp[] = { 0x20, 0x21, 0x1f };
-static const u8 regover[] = { 0x39, 0x3d, 0x1d };
-static const u8 reghyst[] = { 0x3a, 0x3e, 0x1e };
-
 /* temps numbered 1-3 */
-#define VIA686A_REG_TEMP(nr)		(regtemp[nr])
-#define VIA686A_REG_TEMP_OVER(nr)	(regover[nr])
-#define VIA686A_REG_TEMP_HYST(nr)	(reghyst[nr])
+static const u8 VIA686A_REG_TEMP[]	= { 0x20, 0x21, 0x1f };
+static const u8 VIA686A_REG_TEMP_OVER[]	= { 0x39, 0x3d, 0x1d };
+static const u8 VIA686A_REG_TEMP_HYST[]	= { 0x3a, 0x3e, 0x1e };
 /* bits 7-6 */
 #define VIA686A_REG_TEMP_LOW1	0x4b
 /* 2 = bits 5-4, 3 = bits 7-6 */
@@ -441,7 +436,8 @@
 
 	down(&data->update_lock);
 	data->temp_over[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_OVER(nr), data->temp_over[nr]);
+	via686a_write_value(client, VIA686A_REG_TEMP_OVER[nr],
+			    data->temp_over[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -453,7 +449,8 @@
 
 	down(&data->update_lock);
 	data->temp_hyst[nr] = TEMP_TO_REG(val);
-	via686a_write_value(client, VIA686A_REG_TEMP_HYST(nr), data->temp_hyst[nr]);
+	via686a_write_value(client, VIA686A_REG_TEMP_HYST[nr],
+			    data->temp_hyst[nr]);
 	up(&data->update_lock);
 	return count;
 }
@@ -763,13 +760,13 @@
 		}
 		for (i = 0; i <= 2; i++) {
 			data->temp[i] = via686a_read_value(client,
-						 VIA686A_REG_TEMP(i)) << 2;
+						 VIA686A_REG_TEMP[i]) << 2;
 			data->temp_over[i]  			    via686a_read_value(client,
-					       VIA686A_REG_TEMP_OVER(i));
+					       VIA686A_REG_TEMP_OVER[i]);
 			data->temp_hyst[i]  			    via686a_read_value(client,
-					       VIA686A_REG_TEMP_HYST(i));
+					       VIA686A_REG_TEMP_HYST[i]);
 		}
 		/* add in lower 2 bits
 		   temp1 uses bits 7-6 of VIA686A_REG_TEMP_LOW1


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
