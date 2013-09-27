From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 27 Sep 2013 14:34:29 +0000
Subject: [lm-sensors] [PATCH 3/3] staging:iio:ade7753/ade7754/ade7759: Use spi_w8r16be() instead of spi_w8r16
Message-Id: <1380292469-17347-3-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1380292469-17347-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1380292469-17347-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@kernel.org>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-spi@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>

Using spi_w8r16be() will do the conversion of the result from big endian to
native endian in the helper function. This makes the code a bit smaller and also
keeps sparse happy. Fixes the following sparse warnings:

	drivers/staging/iio/meter/ade7753.c:97:29: warning: incorrect type in argument 1 (different base types)
	drivers/staging/iio/meter/ade7753.c:97:29:    expected restricted __be16 const [usertype] *p
	drivers/staging/iio/meter/ade7753.c:97:29:    got unsigned short [usertype] *val

	drivers/staging/iio/meter/ade7754.c:97:29: warning: incorrect type in argument 1 (different base types)
	drivers/staging/iio/meter/ade7754.c:97:29:    expected restricted __be16 const [usertype] *p
	drivers/staging/iio/meter/ade7754.c:97:29:    got unsigned short [usertype] *val

	drivers/staging/iio/meter/ade7759.c:97:29: warning: incorrect type in argument 1 (different base types)
	drivers/staging/iio/meter/ade7759.c:97:29:    expected restricted __be16 const [usertype] *p
	drivers/staging/iio/meter/ade7759.c:97:29:    got unsigned short [usertype] *val

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/meter/ade7753.c | 3 +--
 drivers/staging/iio/meter/ade7754.c | 3 +--
 drivers/staging/iio/meter/ade7759.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/meter/ade7753.c b/drivers/staging/iio/meter/ade7753.c
index 6200335..00492ca 100644
--- a/drivers/staging/iio/meter/ade7753.c
+++ b/drivers/staging/iio/meter/ade7753.c
@@ -86,7 +86,7 @@ static int ade7753_spi_read_reg_16(struct device *dev,
 	struct ade7753_state *st = iio_priv(indio_dev);
 	ssize_t ret;
 
-	ret = spi_w8r16(st->us, ADE7753_READ_REG(reg_address));
+	ret = spi_w8r16be(st->us, ADE7753_READ_REG(reg_address));
 	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
 			reg_address);
@@ -94,7 +94,6 @@ static int ade7753_spi_read_reg_16(struct device *dev,
 	}
 
 	*val = ret;
-	*val = be16_to_cpup(val);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7754.c b/drivers/staging/iio/meter/ade7754.c
index 2e046f6..e0aa13a 100644
--- a/drivers/staging/iio/meter/ade7754.c
+++ b/drivers/staging/iio/meter/ade7754.c
@@ -86,7 +86,7 @@ static int ade7754_spi_read_reg_16(struct device *dev,
 	struct ade7754_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_w8r16(st->us, ADE7754_READ_REG(reg_address));
+	ret = spi_w8r16be(st->us, ADE7754_READ_REG(reg_address));
 	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
 			reg_address);
@@ -94,7 +94,6 @@ static int ade7754_spi_read_reg_16(struct device *dev,
 	}
 
 	*val = ret;
-	*val = be16_to_cpup(val);
 
 	return 0;
 }
diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
index 145f896..ea0c9de 100644
--- a/drivers/staging/iio/meter/ade7759.c
+++ b/drivers/staging/iio/meter/ade7759.c
@@ -86,7 +86,7 @@ static int ade7759_spi_read_reg_16(struct device *dev,
 	struct ade7759_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = spi_w8r16(st->us, ADE7759_READ_REG(reg_address));
+	ret = spi_w8r16be(st->us, ADE7759_READ_REG(reg_address));
 	if (ret < 0) {
 		dev_err(&st->us->dev, "problem when reading 16 bit register 0x%02X",
 			reg_address);
@@ -94,7 +94,6 @@ static int ade7759_spi_read_reg_16(struct device *dev,
 	}
 
 	*val = ret;
-	*val = be16_to_cpup(val);
 
 	return 0;
 }
-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
