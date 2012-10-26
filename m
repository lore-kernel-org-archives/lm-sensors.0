From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Oct 2012 07:58:59 +0000
Subject: [lm-sensors] [PATCH] hwmon (w83627hf) Don't touch nonexistent I2C address registers
Message-Id: <20121026095859.1725b2a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Only the W83627HF could be accessed through I2C. All other supported
chips are LPC-only, so they do not have I2C address registers. Don't
write to nonexistent or reserved registers on these chips.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- linux-3.7-rc2.orig/drivers/hwmon/w83627hf.c	2012-10-26 09:38:18.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83627hf.c	2012-10-26 09:50:44.935025004 +0200
@@ -1732,8 +1732,10 @@ static void __devinit w83627hf_init_devi
 	/* Minimize conflicts with other winbond i2c-only clients...  */
 	/* disable i2c subclients... how to disable main i2c client?? */
 	/* force i2c address to relatively uncommon address */
-	w83627hf_write_value(data, W83781D_REG_I2C_SUBADDR, 0x89);
-	w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
+	if (type = w83627hf) {
+		w83627hf_write_value(data, W83781D_REG_I2C_SUBADDR, 0x89);
+		w83627hf_write_value(data, W83781D_REG_I2C_ADDR, force_i2c);
+	}
 
 	/* Read VID only once */
 	if (type = w83627hf || type = w83637hf) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
