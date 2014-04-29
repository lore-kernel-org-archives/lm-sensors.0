From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:10:17 +0000
Subject: [lm-sensors] [PATCH 4/8] hwmon: (max1111) remove unnecessary OOM messages
Message-Id: <001d01cf6382$74ab10a0$5e0131e0$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/max1111.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/max1111.c b/drivers/hwmon/max1111.c
index eda077d..f67d71e 100644
--- a/drivers/hwmon/max1111.c
+++ b/drivers/hwmon/max1111.c
@@ -192,10 +192,8 @@ static int max1111_probe(struct spi_device *spi)
 		return err;
 
 	data = devm_kzalloc(&spi->dev, sizeof(struct max1111_data), GFP_KERNEL);
-	if (data = NULL) {
-		dev_err(&spi->dev, "failed to allocate memory\n");
+	if (data = NULL)
 		return -ENOMEM;
-	}
 
 	switch (chip) {
 	case max1110:
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
