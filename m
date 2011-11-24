From: Lars-Peter Clausen <lars@metafoo.de>
Date: Thu, 24 Nov 2011 15:29:14 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon: Remove redundant spi driver bus
Message-Id: <1322148561-25138-4-git-send-email-lars@metafoo.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1322148561-25138-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1322148561-25138-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

In ancient times it was necessary to manually initialize the bus field of an
spi_driver to spi_bus_type. These days this is done in spi_driver_register(),
so we can drop the manual assignment.

The patch was generated using the following coccinelle semantic patch:
// <smpl>
@@
identifier _driver;
@@
struct spi_driver _driver = {
	.driver = {
-		.bus = &spi_bus_type,
	},
};
// </smpl>

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: lm-sensors@lm-sensors.org
---
 drivers/hwmon/ad7314.c  |    1 -
 drivers/hwmon/ads7871.c |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/ad7314.c b/drivers/hwmon/ad7314.c
index 318e38e..5d760f3 100644
--- a/drivers/hwmon/ad7314.c
+++ b/drivers/hwmon/ad7314.c
@@ -160,7 +160,6 @@ MODULE_DEVICE_TABLE(spi, ad7314_id);
 static struct spi_driver ad7314_driver = {
 	.driver = {
 		.name = "ad7314",
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 	.probe = ad7314_probe,
diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 5231934..04450f8 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -227,7 +227,6 @@ static int __devexit ads7871_remove(struct spi_device *spi)
 static struct spi_driver ads7871_driver = {
 	.driver = {
 		.name = DEVICE_NAME,
-		.bus = &spi_bus_type,
 		.owner = THIS_MODULE,
 	},
 
-- 
1.7.7.1



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
