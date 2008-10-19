From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 Oct 2008 14:01:14 +0000
Subject: [lm-sensors] [PATCH] hwmon: Don't overuse I2C_CLIENT_MODULE_PARM
Message-Id: <20081019160114.57d4c1c1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I2C_CLIENT_MODULE_PARM is overkill for force_subclients. We really
only use 4 out of the 48 slots, so we're better defining a custom
variable instead. This change saves 92 bytes of data for each of the
five drivers affected.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/asb100.c  |    5 ++++-
 drivers/hwmon/w83781d.c |    5 ++++-
 drivers/hwmon/w83791d.c |    5 ++++-
 drivers/hwmon/w83792d.c |    5 ++++-
 drivers/hwmon/w83793.c  |    5 ++++-
 5 files changed, 20 insertions(+), 5 deletions(-)

--- linux-2.6.28-rc0.orig/drivers/hwmon/w83781d.c	2008-10-18 09:53:51.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/w83781d.c	2008-10-19 14:30:45.000000000 +0200
@@ -58,7 +58,10 @@ static const unsigned short normal_i2c[]
 						0x2e, 0x2f, I2C_CLIENT_END };
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_4(w83781d, w83782d, w83783s, as99127f);
-I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+
+static unsigned short force_subclients[4];
+module_param_array(force_subclients, short, NULL, 0);
+MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
 		    "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int reset;
--- linux-2.6.28-rc0.orig/drivers/hwmon/asb100.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/asb100.c	2008-10-19 14:38:02.000000000 +0200
@@ -53,7 +53,10 @@ static const unsigned short normal_i2c[]
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(asb100);
-I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+
+static unsigned short force_subclients[4];
+module_param_array(force_subclients, short, NULL, 0);
+MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
 	"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 /* Voltage IN registers 0-6 */
--- linux-2.6.28-rc0.orig/drivers/hwmon/w83791d.c	2008-10-18 09:53:51.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/w83791d.c	2008-10-19 14:37:51.000000000 +0200
@@ -53,7 +53,10 @@ static const unsigned short normal_i2c[]
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83791d);
-I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+
+static unsigned short force_subclients[4];
+module_param_array(force_subclients, short, NULL, 0);
+MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
 			"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int reset;
--- linux-2.6.28-rc0.orig/drivers/hwmon/w83792d.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/w83792d.c	2008-10-19 14:37:56.000000000 +0200
@@ -51,7 +51,10 @@ static const unsigned short normal_i2c[]
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83792d);
-I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+
+static unsigned short force_subclients[4];
+module_param_array(force_subclients, short, NULL, 0);
+MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
 			"{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int init;
--- linux-2.6.28-rc0.orig/drivers/hwmon/w83793.c	2008-10-10 09:27:55.000000000 +0200
+++ linux-2.6.28-rc0/drivers/hwmon/w83793.c	2008-10-19 14:38:09.000000000 +0200
@@ -42,7 +42,10 @@ static const unsigned short normal_i2c[]
 
 /* Insmod parameters */
 I2C_CLIENT_INSMOD_1(w83793);
-I2C_CLIENT_MODULE_PARM(force_subclients, "List of subclient addresses: "
+
+static unsigned short force_subclients[4];
+module_param_array(force_subclients, short, NULL, 0);
+MODULE_PARM_DESC(force_subclients, "List of subclient addresses: "
 		       "{bus, clientaddr, subclientaddr1, subclientaddr2}");
 
 static int reset;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
