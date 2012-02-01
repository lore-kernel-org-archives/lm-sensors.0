From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 01 Feb 2012 14:42:31 +0000
Subject: [lm-sensors] [patch] hwmon: (mc13xxx-adc) make name buffer larger
Message-Id: <20120201144231.GB5397@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

This is doesn't change how the code works, it's just a thing to make the
static checkers happy.  We transfer a 12 character string from a 20
character buffer to a 10 character buffer using snprintf().  The static
checkers complain that that lops off the last couple characters.

The static checkers are right, but it turns out we don't care because
later on we truncate the name at the '-' character.  Oh well, let's
change it so they don't complain.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/mc13783-adc.c b/drivers/hwmon/mc13783-adc.c
index e9a7659d..282aaf5 100644
--- a/drivers/hwmon/mc13783-adc.c
+++ b/drivers/hwmon/mc13783-adc.c
@@ -37,7 +37,7 @@
 struct mc13783_adc_priv {
 	struct mc13xxx *mc13xxx;
 	struct device *hwmon_dev;
-	char name[10];
+	char name[PLATFORM_NAME_SIZE];
 };
 
 static ssize_t mc13783_adc_show_name(struct device *dev, struct device_attribute

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
