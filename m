From: Rini van Zetten <rini@arvoo.nl>
Date: Wed, 02 Jun 2010 09:19:50 +0000
Subject: [lm-sensors] [PATCH] [ADT7411] Use 2280 as Vref as specified in
Message-Id: <4C062236.7090808@arvoo.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch changes the 2.25V reference value to 2.28 V as specified in the revB documentation of the chip.
(see : http://www.analog.com/static/imported-files/data_sheets/ADT7411.pdf)

Signed-off-by: Rini <rini@arvoo.nl>
---
 drivers/hwmon/adt7411.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index 4086c72..a08b4d0 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -158,7 +158,7 @@ static ssize_t adt7411_show_input(struct device *dev,
 
 			data->vref_cached = val * 7000 / 1024;
 		} else {
-			data->vref_cached = 2250;
+			data->vref_cached = 2280;
 		}
 
 		data->next_update = jiffies + HZ;
-- 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
