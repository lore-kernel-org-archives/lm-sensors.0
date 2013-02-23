From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Feb 2013 02:19:32 +0000
Subject: [lm-sensors] [PATCH 4/7] hwmon: (pmbus/ltc2978) Use detected chip ID to select supported functionali
Message-Id: <1361585975-5604-4-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We read the chip ID from the chip, use it to determine if the chip ID provided
to the driver is correct, and report it if wrong. We should also use the
correct chip ID to select supported functionality.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for -stable.

 drivers/hwmon/pmbus/ltc2978.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
index eec294a..14f96ae 100644
--- a/drivers/hwmon/pmbus/ltc2978.c
+++ b/drivers/hwmon/pmbus/ltc2978.c
@@ -326,7 +326,7 @@ static int ltc2978_probe(struct i2c_client *client,
 	data->temp_min = 0x7bff;
 	data->temp_max = 0x7c00;
 
-	switch (id->driver_data) {
+	switch (data->id) {
 	case ltc2978:
 		info->read_word_data = ltc2978_read_word_data;
 		info->pages = 8;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
