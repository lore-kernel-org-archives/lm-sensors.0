From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 18 Jul 2013 15:01:11 +0000
Subject: [lm-sensors] [patch v2] hwmon: (nct6775) make an array larger
Message-Id: <20130718150111.GA11991@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

Smatch complains that we have a array overflow:

	drivers/hwmon/nct6775.c:1456 nct6775_update_device()
		error: buffer overflow 'data->temp' 4 <= 4

Guenter Roeck says that the array should have been made larger in
7cbbd6aee6 (Add support for critical low/high temperature limits on
NCT6106).  This patch does that.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: the first version was wrong

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index f0941d7..25e2c7b 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -813,8 +813,8 @@ struct nct6775_data {
 	u8 temp_fixed_num;	/* 3 or 6 */
 	u8 temp_type[NUM_TEMP_FIXED];
 	s8 temp_offset[NUM_TEMP_FIXED];
-	s16 temp[4][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
-				* 3=temp_crit */
+	s16 temp[5][NUM_TEMP]; /* 0=temp, 1=temp_over, 2=temp_hyst,
+				* 3=temp_crit, 4=temp_lcrit */
 	u64 alarms;
 	u64 beeps;
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
