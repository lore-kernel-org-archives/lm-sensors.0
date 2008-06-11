From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 Jun 2008 15:29:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: (thmc50) Safer device detection
Message-Id: <20080611172904.418df3a1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Accepting all values >= 0xc0 as the ADM1022/THMC50 device ID is too
permissive. Only allow the ID range we know these devices may use.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Krzysztof, can you please review and ack this patch? Thanks.

 drivers/hwmon/thmc50.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.26-rc5.orig/drivers/hwmon/thmc50.c	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6.26-rc5/drivers/hwmon/thmc50.c	2008-06-11 17:19:44.000000000 +0200
@@ -295,7 +295,8 @@ static int thmc50_detect(struct i2c_adap
 		kind = thmc50;
 	else if (kind < 0) {
 		err = -ENODEV;
-		if (revision >= 0xc0 && ((config & 0x10) = 0)) {
+		if (revision >= 0xc0 && revision <= 0xdf &&
+		    (config & 0x10) = 0) {
 			if (company = 0x49) {
 				kind = thmc50;
 				err = 0;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
