From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Apr 2008 08:40:39 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm85) Fix function RANGE_TO_REG()
Message-Id: <20080403104039.6e4cb76a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Function RANGE_TO_REG() is broken. For a requested range of 2000 (2
degrees C), it will return an index value of 15, i.e. 80.0 degrees C,
instead of the expected index value of 0. All other values are handled
properly, just 2000 isn't.

The bug was introduced back in November 2004 by this patch:
http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commit;h28d80f1992240373099d863e4996cdd5d646d0

While this can be fixed easily with the current code, I'd rather
rewrite the whole function in a way which is more obviously correct.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Justin Thiessen <jthiessen@penguincomputing.com>
---
 drivers/hwmon/lm85.c |   25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

--- linux-2.6.25-rc8.orig/drivers/hwmon/lm85.c	2008-04-02 22:20:01.000000000 +0200
+++ linux-2.6.25-rc8/drivers/hwmon/lm85.c	2008-04-02 23:10:16.000000000 +0200
@@ -192,23 +192,20 @@ static int RANGE_TO_REG( int range )
 {
 	int i;
 
-	if ( range < lm85_range_map[0] ) { 
-		return 0 ;
-	} else if ( range > lm85_range_map[15] ) {
+	if (range >= lm85_range_map[15])
 		return 15 ;
-	} else {  /* find closest match */
-		for ( i = 14 ; i >= 0 ; --i ) {
-			if ( range > lm85_range_map[i] ) { /* range bracketed */
-				if ((lm85_range_map[i+1] - range) < 
-					(range - lm85_range_map[i])) {
-					i++;
-					break;
-				}
-				break;
-			}
+
+	/* Find the closest match */
+	for (i = 14; i >= 0; --i) {
+		if (range >= lm85_range_map[i]) {
+			if ((lm85_range_map[i + 1] - range) <
+					(range - lm85_range_map[i]))
+				return i + 1;
+			return i;
 		}
 	}
-	return( i & 0x0f );
+
+	return 0;
 }
 #define RANGE_FROM_REG(val) (lm85_range_map[(val)&0x0f])
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
