From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:51 +0000
Subject: [lm-sensors] [PATCH] hwmon: fix array overruns in lm93.c
Message-Id: <11858460013909-git-send-email-mhoffman@lightlink.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4564280785725949170=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============4564280785725949170==

From: Hans-J������rgen Koch <hjk@linutronix.de>

This fixes an array overflow bug. We have 4 pairs of min/max temperature
limits, not 3.

Signed-off-by: Hans J. Koch <hjk@linutronix.de>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/lm93.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm93.c b/drivers/hwmon/lm93.c
index 23edf4f..d84f8bf 100644
--- a/drivers/hwmon/lm93.c
+++ b/drivers/hwmon/lm93.c
@@ -234,7 +234,7 @@ struct lm93_data {
 	struct {
 		u8 min;
 		u8 max;
-	} temp_lim[3];
+	} temp_lim[4];
 
 	/* vin1 - vin16: low and high limits */
 	struct {
-- 
1.5.2.2



--===============4564280785725949170==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4564280785725949170==--
