From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2007 14:30:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627hf) don't assume bank 0
Message-Id: <20071010163023.5b9f87e8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The bank switching code assumes that the bank selector is set to 0
when the driver is loaded. This might not be the case. This is exactly
the same bug as was fixed in the w83627ehf driver two months ago:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h	56895aa6f8dc6a33210967252fd7787652537d

In practice, this bug was causing the sensor thermal types to be
improperly reported for my W83627THF the first time I was loading the
w83627hf driver. From the driver history, I'd say that it has been
broken since September 2005 (when we stopped resetting the chip by
default at driver load.)

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |   44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

--- linux-2.6.23.orig/drivers/hwmon/w83627hf.c	2007-10-10 14:20:13.000000000 +0200
+++ linux-2.6.23/drivers/hwmon/w83627hf.c	2007-10-10 15:53:50.000000000 +0200
@@ -1309,6 +1309,24 @@ static int __devexit w83627hf_remove(str
 }
 
 
+/* Registers 0x50-0x5f are banked */
+static inline void w83627hf_set_bank(struct w83627hf_data *data, u16 reg)
+{
+	if ((reg & 0x00f0) = 0x50) {
+		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(reg >> 8, data->addr + W83781D_DATA_REG_OFFSET);
+	}
+}
+
+/* Not strictly necessary, but play it safe for now */
+static inline void w83627hf_reset_bank(struct w83627hf_data *data, u16 reg)
+{
+	if (reg & 0xff00) {
+		outb_p(W83781D_REG_BANK, data->addr + W83781D_ADDR_REG_OFFSET);
+		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
+	}
+}
+
 static int w83627hf_read_value(struct w83627hf_data *data, u16 reg)
 {
 	int res, word_sized;
@@ -1319,12 +1337,7 @@ static int w83627hf_read_value(struct w8
 		  && (((reg & 0x00ff) = 0x50)
 		   || ((reg & 0x00ff) = 0x53)
 		   || ((reg & 0x00ff) = 0x55));
-	if (reg & 0xff00) {
-		outb_p(W83781D_REG_BANK,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(reg >> 8,
-		       data->addr + W83781D_DATA_REG_OFFSET);
-	}
+	w83627hf_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
 	res = inb_p(data->addr + W83781D_DATA_REG_OFFSET);
 	if (word_sized) {
@@ -1334,11 +1347,7 @@ static int w83627hf_read_value(struct w8
 		    (res << 8) + inb_p(data->addr +
 				       W83781D_DATA_REG_OFFSET);
 	}
-	if (reg & 0xff00) {
-		outb_p(W83781D_REG_BANK,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
-	}
+	w83627hf_reset_bank(data, reg);
 	mutex_unlock(&data->lock);
 	return res;
 }
@@ -1409,12 +1418,7 @@ static int w83627hf_write_value(struct w
 		   || ((reg & 0xff00) = 0x200))
 		  && (((reg & 0x00ff) = 0x53)
 		   || ((reg & 0x00ff) = 0x55));
-	if (reg & 0xff00) {
-		outb_p(W83781D_REG_BANK,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(reg >> 8,
-		       data->addr + W83781D_DATA_REG_OFFSET);
-	}
+	w83627hf_set_bank(data, reg);
 	outb_p(reg & 0xff, data->addr + W83781D_ADDR_REG_OFFSET);
 	if (word_sized) {
 		outb_p(value >> 8,
@@ -1424,11 +1428,7 @@ static int w83627hf_write_value(struct w
 	}
 	outb_p(value & 0xff,
 	       data->addr + W83781D_DATA_REG_OFFSET);
-	if (reg & 0xff00) {
-		outb_p(W83781D_REG_BANK,
-		       data->addr + W83781D_ADDR_REG_OFFSET);
-		outb_p(0, data->addr + W83781D_DATA_REG_OFFSET);
-	}
+	w83627hf_reset_bank(data, reg);
 	mutex_unlock(&data->lock);
 	return 0;
 }


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
