From: Roel Kluin <roel.kluin@gmail.com>
Date: Tue, 17 Feb 2009 13:17:54 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add missing parentheses
Message-Id: <499AB902.1080308@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think this was intended? please review.
--------------------------->8-------------8<------------------------------
Add missing parentheses

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/drivers/hwmon/abituguru3.c b/drivers/hwmon/abituguru3.c
index e52b388..fd98685 100644
--- a/drivers/hwmon/abituguru3.c
+++ b/drivers/hwmon/abituguru3.c
@@ -761,7 +761,7 @@ static int abituguru3_read_increment_offset(struct abituguru3_data *data,
 	for (i = 0; i < offset_count; i++)
 		if ((x = abituguru3_read(data, bank, offset + i, count,
 				buf + i * count)) != count)
-			return i * count + (i && (x < 0)) ? 0 : x;
+			return i * count + ((i && (x < 0)) ? 0 : x);
 
 	return i * count;
 }

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
