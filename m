From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Feb 2011 02:58:52 +0000
Subject: [lm-sensors] [PATCH 1/6] hwmon: (w83627ehf) Skip in6 and temp3 only
Message-Id: <1297308953-3479-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

temp3 and in6 are mutually exclusive only on W83667HG, not on W83667HG-B.
All other chips support both at the same time.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/w83627ehf.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 073eabe..415c448 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1398,7 +1398,7 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 			 || sio_data->kind = w83667hg_b) ? 3 : 4;
 
 	/* Check temp3 configuration bit for 667HG */
-	if (sio_data->kind = w83667hg || sio_data->kind = w83667hg_b) {
+	if (sio_data->kind = w83667hg) {
 		data->temp3_disable = w83627ehf_read_value(data,
 					W83627EHF_REG_TEMP_CONFIG[1]) & 0x01;
 		data->in6_skip = !data->temp3_disable;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
