From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 14:27:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sis5595) Prevent overflow problem when writing large limits
Message-Id: <1406816824.5354.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip. Avoid auto-conversion from long to int to fix
the problem.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/sis5595.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/sis5595.c b/drivers/hwmon/sis5595.c
index 3532026..bf1d789 100644
--- a/drivers/hwmon/sis5595.c
+++ b/drivers/hwmon/sis5595.c
@@ -159,7 +159,7 @@ static inline int TEMP_FROM_REG(s8 val)
 {
 	return val * 830 + 52120;
 }
-static inline s8 TEMP_TO_REG(int val)
+static inline s8 TEMP_TO_REG(long val)
 {
 	int nval = clamp_val(val, -54120, 157530) ;
 	return nval < 0 ? (nval - 5212 - 415) / 830 : (nval - 5212 + 415) / 830;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
