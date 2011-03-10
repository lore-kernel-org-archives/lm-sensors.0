From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 10 Mar 2011 23:56:12 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Display correct temperature
Message-Id: <1299801372-2422-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Systems with NCT6775F reported temperature sensor labels for systems with
NCT6776F. This patch fixes the problem.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
This patch has to be applied on top of the other pending patches for
NCT6775F/NCT6776F support.

An updated standalone driver is available at
	http://www.roeck-us.net/linux/drivers/w83627ehf/.

 drivers/hwmon/w83627ehf.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index 460292b..628666b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -1894,9 +1894,10 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 				else
 					data->in6_skip = 1;
 			}
+			data->temp_label = nct6776_temp_label;
+		} else {
+			data->temp_label = nct6775_temp_label;
 		}
-
-		data->temp_label = nct6776_temp_label;
 	} else if (sio_data->kind = w83667hg_b) {
 		u8 reg;
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
