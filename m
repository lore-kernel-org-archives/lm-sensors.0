From: Sachin Kamat <sachin.kamat@linaro.org>
Date: Wed, 11 Sep 2013 04:31:50 +0000
Subject: [lm-sensors] [PATCH 3/5] hwmon: (amc6821) Fix return value
Message-Id: <1378873192-6297-3-git-send-email-sachin.kamat@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Propagate return value obtained from i2c_smbus_read_byte_data()
instead of hardcoding.

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: T. Mertelj <tomaz.mertelj@guest.arnes.si>
---
 drivers/hwmon/amc6821.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/amc6821.c b/drivers/hwmon/amc6821.c
index 4fe49d2..fcb1853 100644
--- a/drivers/hwmon/amc6821.c
+++ b/drivers/hwmon/amc6821.c
@@ -364,7 +364,7 @@ static ssize_t set_pwm1_enable(
 	if (config < 0) {
 			dev_err(&client->dev,
 			"Error reading configuration register, aborting.\n");
-			return -EIO;
+			return config;
 	}
 
 	switch (val) {
@@ -665,7 +665,7 @@ static ssize_t set_fan1_div(
 	if (config < 0) {
 		dev_err(&client->dev,
 			"Error reading configuration register, aborting.\n");
-		return -EIO;
+		return config;
 	}
 	mutex_lock(&data->update_lock);
 	switch (val) {
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
