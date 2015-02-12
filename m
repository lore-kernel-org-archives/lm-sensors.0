From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Date: Thu, 12 Feb 2015 14:15:17 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (ibmpex) Allow format string checking
Message-Id: <1423750517-26439-3-git-send-email-linux@rasmusvillemoes.dk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
In-Reply-To: <1423750517-26439-1-git-send-email-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

The only difference between the three power_sensor_name_templates is
whether there is a suffix of "", "_lowest" or "_highest". We might as
well pull those into an array and use a literal format string,
allowing gcc to do type checking of the arguments to
sprintf. Incidentially, the same three suffixes are used in the
temp_sensor_name_templates case, so we end up eliminating one static
array.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
 drivers/hwmon/ibmpex.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 030e7ff589be..2eb672299a31 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -56,15 +56,10 @@ static u8 const temp_sensor_sig[]  = {0x74, 0x65, 0x6D};
 static u8 const watt_sensor_sig[]  = {0x41, 0x43};
 
 #define PEX_NUM_SENSOR_FUNCS	3
-static char const * const power_sensor_name_templates[] = {
-	"%s%d_average",
-	"%s%d_average_lowest",
-	"%s%d_average_highest"
-};
-static char const * const temp_sensor_name_templates[] = {
-	"%s%d_input",
-	"%s%d_input_lowest",
-	"%s%d_input_highest"
+static const char * const sensor_name_suffixes[] = {
+	"",
+	"_lowest",
+	"_highest"
 };
 
 static void ibmpex_msg_handler(struct ipmi_recv_msg *msg, void *user_msg_data);
@@ -355,9 +350,9 @@ static int create_sensor(struct ibmpex_bmc_data *data, int type,
 		return -ENOMEM;
 
 	if (type = TEMP_SENSOR)
-		sprintf(n, temp_sensor_name_templates[func], "temp", counter);
+		sprintf(n, "temp%d_input%s", counter, sensor_name_suffixes[func]);
 	else if (type = POWER_SENSOR)
-		sprintf(n, power_sensor_name_templates[func], "power", counter);
+		sprintf(n, "power%d_average%s", counter, sensor_name_suffixes[func]);
 
 	sysfs_attr_init(&data->sensors[sensor].attr[func].dev_attr.attr);
 	data->sensors[sensor].attr[func].dev_attr.attr.name = n;
-- 
2.1.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
