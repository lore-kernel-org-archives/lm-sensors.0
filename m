From: ralf@linux-mips.org (Ralf Baechle)
Date: Sun, 10 Dec 2006 19:21:51 +0000
Subject: [lm-sensors] [PATCH] Make lm70_remove a __devexit function
Message-Id: <20061210192151.GA32262@linux-mips.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Saves a few bytes on the module.

Signed-off-by: Ralf Baechle <ralf at linux-mips.org>

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 6ba8473..7eaae38 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -126,7 +126,7 @@ out_dev_reg_failed:
 	return status;
 }
 
-static int __exit lm70_remove(struct spi_device *spi)
+static int __devexit lm70_remove(struct spi_device *spi)
 {
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
 

