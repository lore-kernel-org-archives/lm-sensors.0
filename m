From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 21:28:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adm1275) Fix coefficients per
Message-Id: <1310678901-30378-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Coefficients to convert chip register values to voltage/current have been
slightly changed in revision B of the chip datasheet. Update driver coefficients
to match the coefficients in the datasheet.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/adm1275.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
index b9b7caf..8bc1bd6 100644
--- a/drivers/hwmon/adm1275.c
+++ b/drivers/hwmon/adm1275.c
@@ -53,23 +53,23 @@ static int adm1275_probe(struct i2c_client *client,
 	info->direct[PSC_VOLTAGE_IN] = true;
 	info->direct[PSC_VOLTAGE_OUT] = true;
 	info->direct[PSC_CURRENT_OUT] = true;
-	info->m[PSC_CURRENT_OUT] = 800;
+	info->m[PSC_CURRENT_OUT] = 807;
 	info->b[PSC_CURRENT_OUT] = 20475;
 	info->R[PSC_CURRENT_OUT] = -1;
 	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
 
 	if (config & ADM1275_VRANGE) {
-		info->m[PSC_VOLTAGE_IN] = 19045;
+		info->m[PSC_VOLTAGE_IN] = 19199;
 		info->b[PSC_VOLTAGE_IN] = 0;
 		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 19045;
+		info->m[PSC_VOLTAGE_OUT] = 19199;
 		info->b[PSC_VOLTAGE_OUT] = 0;
 		info->R[PSC_VOLTAGE_OUT] = -2;
 	} else {
-		info->m[PSC_VOLTAGE_IN] = 6666;
+		info->m[PSC_VOLTAGE_IN] = 6720;
 		info->b[PSC_VOLTAGE_IN] = 0;
 		info->R[PSC_VOLTAGE_IN] = -1;
-		info->m[PSC_VOLTAGE_OUT] = 6666;
+		info->m[PSC_VOLTAGE_OUT] = 6720;
 		info->b[PSC_VOLTAGE_OUT] = 0;
 		info->R[PSC_VOLTAGE_OUT] = -1;
 	}
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
