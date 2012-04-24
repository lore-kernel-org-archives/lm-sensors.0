From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Apr 2012 03:36:57 +0000
Subject: [lm-sensors] [PATCH 2/4] hwmon: (ntc_thermistor) Fix checkpatch warning
Message-Id: <1335238619-25745-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix checkpatch WARNING: quoted string split across lines

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Donggeun Kim <dg77.kim@samsung.com>
---
 drivers/hwmon/ntc_thermistor.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ntc_thermistor.c b/drivers/hwmon/ntc_thermistor.c
index d06e354..6b131252 100644
--- a/drivers/hwmon/ntc_thermistor.c
+++ b/drivers/hwmon/ntc_thermistor.c
@@ -322,14 +322,14 @@ static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
 
 	/* Either one of the two is required. */
 	if (!pdata->read_uV && !pdata->read_ohm) {
-		dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
-				"Need either one of the two.\n");
+		dev_err(&pdev->dev,
+			"Both read_uV and read_ohm missing. Need either one of the two.\n");
 		return -EINVAL;
 	}
 
 	if (pdata->read_uV && pdata->read_ohm) {
-		dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
-				"is needed; ignoring read_uV.\n");
+		dev_warn(&pdev->dev,
+			 "Only one of read_uV and read_ohm is needed; ignoring read_uV.\n");
 		pdata->read_uV = NULL;
 	}
 
@@ -340,8 +340,8 @@ static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
 				 NTC_CONNECTED_POSITIVE) ||
 				(pdata->connect != NTC_CONNECTED_POSITIVE &&
 				 pdata->connect != NTC_CONNECTED_GROUND))) {
-		dev_err(&pdev->dev, "Required data to use read_uV not "
-				"supplied.\n");
+		dev_err(&pdev->dev,
+			"Required data to use read_uV not supplied.\n");
 		return -EINVAL;
 	}
 
-- 
1.7.9.48.g85da4d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
