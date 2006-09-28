From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:29 +0000
Subject: [lm-sensors] [PATCH 9/39] it87: in8 has no limit registers
Message-Id: <11594837671949-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

it87: in8 has no limit registers

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/it87.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index fc75fcb..bfad897 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -220,8 +220,8 @@ struct it87_data {
 	unsigned long last_updated;	/* In jiffies */
 
 	u8 in[9];		/* Register value */
-	u8 in_max[9];		/* Register value */
-	u8 in_min[9];		/* Register value */
+	u8 in_max[8];		/* Register value */
+	u8 in_min[8];		/* Register value */
 	u8 has_fan;		/* Bitfield, fans enabled */
 	u16 fan[3];		/* Register values, possibly combined */
 	u16 fan_min[3];		/* Register values, possibly combined */
@@ -1251,12 +1251,9 @@ static struct it87_data *it87_update_dev
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
1.4.2.1


