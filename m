From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 18 Mar 2013 10:48:10 +0000
Subject: [lm-sensors] [PATCH] hwmon: (adt7310) Fix sparse warning
Message-Id: <1363603690-18217-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix: drivers/hwmon/adt7310.c:51:16: sparse: cast to restricted __be16

Cc: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/adt7310.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index b70a481..da5f078 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -48,7 +48,7 @@ static int adt7310_spi_read_word(struct device *dev, u8 reg)
 	if (ret < 0)
 		return ret;
 
-	return be16_to_cpu(ret);
+	return be16_to_cpu((__force __be16)ret);
 }
 
 static int adt7310_spi_write_word(struct device *dev, u8 reg, u16 data)
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
