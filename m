From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Oct 2009 11:27:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (thmc50) Stop using
Message-Id: <20091009132729.38bb060d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Subject: hwmon: (thmc50) Stop using I2C_CLIENT_MODULE_PARM

The thmc50 driver is the last user of I2C_CLIENT_MODULE_PARM, and I
would like to get rid of that macro.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>
---
Krzysztof, can you please test this patch?

 drivers/hwmon/thmc50.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-2.6.32-rc3.orig/drivers/hwmon/thmc50.c	2009-10-09 12:51:22.000000000 +0200
+++ linux-2.6.32-rc3/drivers/hwmon/thmc50.c	2009-10-09 12:56:55.000000000 +0200
@@ -36,7 +36,11 @@ static const unsigned short normal_i2c[]
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_2(thmc50, adm1022);
-I2C_CLIENT_MODULE_PARM(adm1022_temp3, "List of adapter,address pairs "
+
+static unsigned short adm1022_temp3[16];
+static unsigned int adm1022_temp3_num;
+module_param_array(adm1022_temp3, ushort, &adm1022_temp3_num, 0);
+MODULE_PARM_DESC(adm1022_temp3, "List of adapter,address pairs "
 			"to enable 3rd temperature (ADM1022 only)");
 
 /* Many THMC50 constants specified below */

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
