From: Andres Salomon <dilinger@queued.net>
Date: Tue, 01 Mar 2011 21:35:48 +0000
Subject: [lm-sensors] [PATCH] jz4740: silence warnings related to
Message-Id: <20110301133548.6acb5170@debxo>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, Anton Vorontsov <cbouatmailru@gmail.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org


mfd_get_cell returns a const, so change the jz4740 clients to store
a const mfd cell.  This silences type mismatch warnings.

Signed-off-by: Andres Salomon <dilinger@queued.net>
---
 drivers/hwmon/jz4740-hwmon.c   |    2 +-
 drivers/power/jz4740-battery.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/jz4740-hwmon.c b/drivers/hwmon/jz4740-hwmon.c
index 40f106d..fea292d 100644
--- a/drivers/hwmon/jz4740-hwmon.c
+++ b/drivers/hwmon/jz4740-hwmon.c
@@ -32,7 +32,7 @@ struct jz4740_hwmon {
 
 	int irq;
 
-	struct mfd_cell *cell;
+	const struct mfd_cell *cell;
 	struct device *hwmon;
 
 	struct completion read_completion;
diff --git a/drivers/power/jz4740-battery.c b/drivers/power/jz4740-battery.c
index 0938650..763f894 100644
--- a/drivers/power/jz4740-battery.c
+++ b/drivers/power/jz4740-battery.c
@@ -39,7 +39,7 @@ struct jz_battery {
 	int irq;
 	int charge_irq;
 
-	struct mfd_cell *cell;
+	const struct mfd_cell *cell;
 
 	int status;
 	long voltage;
-- 
1.7.2.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
