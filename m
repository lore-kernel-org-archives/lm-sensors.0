From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 08:36:53 +0000
Subject: [lm-sensors] [PATCH] Drivers: hwmon: adm1031: fixed spacing coding
Message-Id: <1321605413-13614-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed spacing coding style issues.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/hwmon/adm1031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 0683e6b..694392b 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -1058,7 +1058,7 @@ static struct adm1031_data *adm1031_update_device(struct device *dev)
 			data->alarm &= 0xc0ff;
 		}
 
-		for (chan=0; chan<(data->chip_type = adm1030 ? 1 : 2); chan++) {
+		for (chan = 0; chan < (data->chip_type = adm1030 ? 1 : 2); chan++) {
 			data->fan_div[chan]  			    adm1031_read_value(client, ADM1031_REG_FAN_DIV(chan));
 			data->fan_min[chan] -- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
