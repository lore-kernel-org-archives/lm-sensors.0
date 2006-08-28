From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:27:25 +0000
Subject: [lm-sensors] [PATCH 07/14] it87: in8 has no limit registers
Message-Id: <20060828142725.18716798.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-it87-in8-no-limits.patch

it87: in8 has no limit registers

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/it87.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/it87.c	2006-08-25 19:15:37.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/it87.c	2006-08-25 19:15:40.000000000 +0200
@@ -220,8 +220,8 @@
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 in[9];		/* Register value */
-	u8 in_max[9];		/* Register value */
-	u8 in_min[9];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
@@ -1250,12 +1250,9 @@
 			data->in_max[i]  			    it87_read_value(client, IT87_REG_VIN_MAX(i));
 		}
+		/* in8 (battery) has no limit registers */
 		data->in[8]  		    it87_read_value(client, IT87_REG_VIN(8));
-		/* Temperature sensor doesn't have limit registers, set
-		   to min and max value */
-		data->in_min[8] = 0;
-		data->in_max[8] = 255;
 
 		for (i = 0; i < 3; i++) {
 			/* Skip disabled fans */

-- 
Jean Delvare

