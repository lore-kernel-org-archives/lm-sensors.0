From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 23:41:29 +0000
Subject: [lm-sensors] [PATCH 1/7] hwmon: (pmbus) Removed unused variable
Message-Id: <1302133295-17302-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

struct pmbus_data included an unused variable named status_bits.
Remove it.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Reviewed-by: Tom Grennan <tom.grennan@ericsson.com>
---
 drivers/hwmon/pmbus_core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
index edfb92e..196ffaf 100644
--- a/drivers/hwmon/pmbus_core.c
+++ b/drivers/hwmon/pmbus_core.c
@@ -139,7 +139,6 @@ struct pmbus_data {
 	 * A single status register covers multiple attributes,
 	 * so we keep them all together.
 	 */
-	u8 status_bits;
 	u8 status[PB_NUM_STATUS_REG];
 
 	u8 currpage;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
