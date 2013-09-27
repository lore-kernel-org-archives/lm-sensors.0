From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 27 Sep 2013 14:34:28 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (adt7310) Use spi_w8r16be() instead spi_w8r16()
Message-Id: <1380292469-17347-2-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380292469-17347-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Using spi_w8r16be() instead of spi_w8r16() in this driver makes a code a bit
shorter and cleaner.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/hwmon/adt7310.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/hwmon/adt7310.c b/drivers/hwmon/adt7310.c
index da5f078..5994cf6 100644
--- a/drivers/hwmon/adt7310.c
+++ b/drivers/hwmon/adt7310.c
@@ -42,13 +42,8 @@ static const u8 adt7310_reg_table[] = {
 static int adt7310_spi_read_word(struct device *dev, u8 reg)
 {
 	struct spi_device *spi = to_spi_device(dev);
-	int ret;
 
-	ret = spi_w8r16(spi, AD7310_COMMAND(reg) | ADT7310_CMD_READ);
-	if (ret < 0)
-		return ret;
-
-	return be16_to_cpu((__force __be16)ret);
+	return spi_w8r16be(spi, AD7310_COMMAND(reg) | ADT7310_CMD_READ);
 }
 
 static int adt7310_spi_write_word(struct device *dev, u8 reg, u16 data)
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
