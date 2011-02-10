From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 15:49:07 +0000
Subject: [lm-sensors] [PATCH v2 3/5] hwmon: (w83627ehf) Optimize multi-bank
Message-Id: <1297352949-25602-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Assume that each register is banked, and set the bank for each access.
Cache the bank number so it only needs to be set if it changes.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83627ehf.c |   26 +++++++++++---------------
 1 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index b4f489e..8c39085 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -304,6 +304,7 @@ struct w83627ehf_data {
 	unsigned long last_updated;	/* In jiffies */
 
 	/* Register values */
+	u8 bank;		/* current register bank */
 	u8 in_num;		/* number of in inputs we have */
 	u8 in[10];		/* Register value */
 	u8 in_max[10];		/* Register value */
@@ -347,21 +348,19 @@ struct w83627ehf_sio_data {
 	enum kinds kind;
 };
 
-/* Registers 0x50-0x5f are banked */
+/*
+ * On older chips, only registers 0x50-0x5f are banked.
+ * On more recent chips, all registers are banked.
+ * Assume that is the case and set the bank number for each access.
+ * Cache the bank number so it only needs to be set if it changes.
+ */
 static inline void w83627ehf_set_bank(struct w83627ehf_data *data, u16 reg)
 {
-	if ((reg & 0x00f0) = 0x50) {
-		outb_p(W83627EHF_REG_BANK, data->addr + ADDR_REG_OFFSET);
-		outb_p(reg >> 8, data->addr + DATA_REG_OFFSET);
-	}
-}
-
-/* Not strictly necessary, but play it safe for now */
-static inline void w83627ehf_reset_bank(struct w83627ehf_data *data, u16 reg)
-{
-	if (reg & 0xff00) {
+	u8 bank = reg >> 8;
+	if (data->bank != bank) {
 		outb_p(W83627EHF_REG_BANK, data->addr + ADDR_REG_OFFSET);
-		outb_p(0, data->addr + DATA_REG_OFFSET);
+		outb_p(bank, data->addr + DATA_REG_OFFSET);
+		data->bank = bank;
 	}
 }
 
@@ -379,10 +378,8 @@ static u16 w83627ehf_read_value(struct w83627ehf_data *data, u16 reg)
 		       data->addr + ADDR_REG_OFFSET);
 		res = (res << 8) + inb_p(data->addr + DATA_REG_OFFSET);
 	}
-	w83627ehf_reset_bank(data, reg);
 
 	mutex_unlock(&data->lock);
-
 	return res;
 }
 
@@ -401,7 +398,6 @@ static int w83627ehf_write_value(struct w83627ehf_data *data, u16 reg,
 		       data->addr + ADDR_REG_OFFSET);
 	}
 	outb_p(value & 0xff, data->addr + DATA_REG_OFFSET);
-	w83627ehf_reset_bank(data, reg);
 
 	mutex_unlock(&data->lock);
 	return 0;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
