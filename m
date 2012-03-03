From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Mar 2012 21:28:19 +0000
Subject: [lm-sensors] [PATCH 3/3] sensord: Avoid strcat
Message-Id: <20120303222819.622c619a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Calling strcat twice in a row is inefficient, it's better to use
sprintf at the end of the string, so that we look for that end only
once.
---
 prog/sensord/sense.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- lm-sensors.orig/prog/sensord/sense.c	2012-03-03 19:07:43.000000000 +0100
+++ lm-sensors/prog/sensord/sense.c	2012-03-03 20:30:47.981351697 +0100
@@ -114,10 +114,8 @@ static int do_features(const sensors_chi
 		if (feature->rrd) {
 			const char *rrded = feature->rrd(val);
 
-			/* FIXME: Jean's review comment:
-			 * sprintf would me more efficient.
-			 */
-			strcat(strcat (rrdBuff, ":"), rrded ? rrded : "U");
+			sprintf(rrdBuff + strlen(rrdBuff), ":%s",
+				rrded ? rrded : "U");
 		}
 
 		return 0;

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
