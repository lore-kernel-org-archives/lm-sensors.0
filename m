From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 24 Feb 2011 02:22:01 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: adt7411: add MODULE_DEVICE_TABLE
Message-Id: <1298514121.19027.5.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298514037.19027.3.camel@mola>
In-Reply-To: <1298514037.19027.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

The device table is required to load modules based on modaliases.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/adt7411.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/adt7411.c b/drivers/hwmon/adt7411.c
index f13c843..5cc3e37 100644
--- a/drivers/hwmon/adt7411.c
+++ b/drivers/hwmon/adt7411.c
@@ -334,6 +334,7 @@ static const struct i2c_device_id adt7411_id[] = {
 	{ "adt7411", 0 },
 	{ }
 };
+MODULE_DEVICE_TABLE(i2c, adt7411_id);
 
 static struct i2c_driver adt7411_driver = {
 	.driver		= {
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
