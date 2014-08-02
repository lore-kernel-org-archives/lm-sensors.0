From: Axel Lin <axel.lin@ingics.com>
Date: Sat, 02 Aug 2014 05:36:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: (gpio-fan) Prevent overflow problem when writing large limits
Message-Id: <1406957798.14101.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(unsigned long), writing a rpm value
larger than MAXINT will result in unpredictable limit values written to the
chip. Avoid auto-conversion from unsigned long to int to fix the problem.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/gpio-fan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index a43e5b0..4efa173 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -173,7 +173,7 @@ static int get_fan_speed_index(struct gpio_fan_data *fan_data)
 	return -ENODEV;
 }
 
-static int rpm_to_speed_index(struct gpio_fan_data *fan_data, int rpm)
+static int rpm_to_speed_index(struct gpio_fan_data *fan_data, unsigned long rpm)
 {
 	struct gpio_fan_speed *speed = fan_data->speed;
 	int i;
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
