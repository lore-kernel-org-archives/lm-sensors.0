From: Johannes Pointner <johannes.pointner@gmail.com>
Date: Mon, 25 Aug 2014 08:04:45 +0000
Subject: [lm-sensors] [PATCH] iio:inkern: fix overwritten -EPROBE_DEFER in of_iio_channel_get_by_name
Message-Id: <1472905.aEm3bdqRZp@lenovobook>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, 'Guenter Roeck' <linux@roeck-us.net>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, linux-iio <linux-iio@vger.kernel.org>

This patch fixes the overwritten -EPROBE_DEFER return value in of_iio_channel_get_by_name.

Signed-off-by: Johannes Pointner <johannes.pointner@br-automation.com>
---
 drivers/iio/inkern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index c749700..f084610 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -178,7 +178,7 @@ static struct iio_channel *of_iio_channel_get_by_name(struct device_node *np,
 			index = of_property_match_string(np, "io-channel-names",
 							 name);
 		chan = of_iio_channel_get(np, index);
-		if (!IS_ERR(chan))
+		if (!IS_ERR(chan) || PTR_ERR(chan) = -EPROBE_DEFER)
 			break;
 		else if (name && index >= 0) {
 			pr_err("ERROR: could not get IIO channel %s:%s(%i)\n",
-- 
2.1.0

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
