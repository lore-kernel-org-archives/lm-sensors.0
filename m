From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:39:33 +0000
Subject: [lm-sensors] [PATCH 13/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126204034.4c195439.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-04-macintosh.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for macintosh.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/macintosh/therm_adt746x.c        |    6 ++++--
 drivers/macintosh/therm_pm72.c           |    6 ++++--
 drivers/macintosh/therm_windtunnel.c     |    6 ++++--
 drivers/macintosh/windfarm_lm75_sensor.c |    6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

--- linux-2.6.15-rc1.orig/drivers/macintosh/therm_adt746x.c	2005-11-13 10:51:02.000000000 +0100
+++ linux-2.6.15-rc1/drivers/macintosh/therm_adt746x.c	2005-11-13 11:20:11.000000000 +0100
@@ -171,8 +171,10 @@
 }
 
 static struct i2c_driver thermostat_driver = {  
-	.owner		= THIS_MODULE,
-	.name		= "therm_adt746x",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "therm_adt746x",
+	},
 	.attach_adapter	= attach_thermostat,
 	.detach_adapter	= detach_thermostat,
 };
--- linux-2.6.15-rc1.orig/drivers/macintosh/therm_pm72.c	2005-11-13 10:51:02.000000000 +0100
+++ linux-2.6.15-rc1/drivers/macintosh/therm_pm72.c	2005-11-13 11:20:11.000000000 +0100
@@ -283,8 +283,10 @@
 
 static struct i2c_driver therm_pm72_driver  {
-	.owner		= THIS_MODULE,
-	.name		= "therm_pm72",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "therm_pm72",
+	},
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
 };
--- linux-2.6.15-rc1.orig/drivers/macintosh/therm_windtunnel.c	2005-11-13 10:51:02.000000000 +0100
+++ linux-2.6.15-rc1/drivers/macintosh/therm_windtunnel.c	2005-11-13 11:20:11.000000000 +0100
@@ -354,8 +354,10 @@
 }
 
 static struct i2c_driver g4fan_driver = {  
-	.owner		= THIS_MODULE,
-	.name		= "therm_windtunnel",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "therm_windtunnel",
+	},
 	.id		= I2C_DRIVERID_G4FAN,
 	.attach_adapter = do_attach,
 	.detach_client	= do_detach,
--- linux-2.6.15-rc1.orig/drivers/macintosh/windfarm_lm75_sensor.c	2005-11-13 10:58:52.000000000 +0100
+++ linux-2.6.15-rc1/drivers/macintosh/windfarm_lm75_sensor.c	2005-11-13 11:20:11.000000000 +0100
@@ -47,8 +47,10 @@
 static int wf_lm75_detach(struct i2c_client *client);
 
 static struct i2c_driver wf_lm75_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "wf_lm75",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "wf_lm75",
+	},
 	.attach_adapter	= wf_lm75_attach,
 	.detach_client	= wf_lm75_detach,
 };

-- 
Jean Delvare
