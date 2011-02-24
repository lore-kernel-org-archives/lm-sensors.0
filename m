From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 24 Feb 2011 02:20:37 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: ad7414: add MODULE_DEVICE_TABLE
Message-Id: <1298514037.19027.3.camel@mola>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Sean MacLennan <smaclennan@pikatech.com>, Frank Edelhaeuser <frank.edelhaeuser@spansion.com>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org

The device table is required to load modules based on modaliases.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/ad7414.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ad7414.c b/drivers/hwmon/ad7414.c
index 86d822a..d46c0c7 100644
--- a/drivers/hwmon/ad7414.c
+++ b/drivers/hwmon/ad7414.c
@@ -242,6 +242,7 @@ static const struct i2c_device_id ad7414_id[] = {
 	{ "ad7414", 0 },
 	{}
 };
+MODULE_DEVICE_TABLE(i2c, ad7414_id);
 
 static struct i2c_driver ad7414_driver = {
 	.driver = {
-- 
1.7.2




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
