From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 11 Sep 2013 04:31:51 +0000
Subject: [lm-sensors] [PATCH 4/5] hwmon: (amc6821) Remove redundant break
Message-Id: <1378873192-6297-4-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

'break' after return or goto has no effect. Remove it.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: T. Mertelj <tomaz.mertelj@guest.arnes.si>
---
 drivers/hwmon/amc6821.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index fcb1853..eea8172 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -416,11 +416,9 @@ static ssize_t get_temp_auto_point_temp(
 	case 1:
 		return sprintf(buf, "%d\n",
 			data->temp1_auto_point_temp[ix] * 1000);
-		break;
 	case 2:
 		return sprintf(buf, "%d\n",
 			data->temp2_auto_point_temp[ix] * 1000);
-		break;
 	default:
 		dev_dbg(dev, "Unknown attr->nr (%d).\n", nr);
 		return -EINVAL;
@@ -513,7 +511,6 @@ static ssize_t set_temp_auto_point_temp(
 				count = -EIO;
 		}
 		goto EXIT;
-		break;
 	case 1:
 		ptemp[1] = clamp_val(val / 1000, (ptemp[0] & 0x7C) + 4, 124);
 		ptemp[1] &= 0x7C;
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
