From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:11 +0000
Subject: [lm-sensors] [patch 4/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212541.721970000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the drivers for macintosh.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/macintosh/therm_adt746x.c        |    6 ++++--
 drivers/macintosh/therm_pm72.c           |    6 ++++--
 drivers/macintosh/therm_windtunnel.c     |    6 ++++--
 drivers/macintosh/windfarm_lm75_sensor.c |    6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

Index: linux-2.6-mm/drivers/macintosh/therm_adt746x.c
=================================--- linux-2.6-mm.orig/drivers/macintosh/therm_adt746x.c
+++ linux-2.6-mm/drivers/macintosh/therm_adt746x.c
@@ -171,8 +171,10 @@
 }
 
 static struct i2c_driver thermostat_driver = {  
-	.owner		= THIS_MODULE,
-	.name		= "therm_adt746x",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "therm_adt746x",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= attach_thermostat,
 	.detach_adapter	= detach_thermostat,
Index: linux-2.6-mm/drivers/macintosh/therm_pm72.c
=================================--- linux-2.6-mm.orig/drivers/macintosh/therm_pm72.c
+++ linux-2.6-mm/drivers/macintosh/therm_pm72.c
@@ -283,8 +283,10 @@
 
 static struct i2c_driver therm_pm72_driver  {
-	.owner		= THIS_MODULE,
-	.name		= "therm_pm72",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "therm_pm72",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
Index: linux-2.6-mm/drivers/macintosh/therm_windtunnel.c
=================================--- linux-2.6-mm.orig/drivers/macintosh/therm_windtunnel.c
+++ linux-2.6-mm/drivers/macintosh/therm_windtunnel.c
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
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter = do_attach,
Index: linux-2.6-mm/drivers/macintosh/windfarm_lm75_sensor.c
=================================--- linux-2.6-mm.orig/drivers/macintosh/windfarm_lm75_sensor.c
+++ linux-2.6-mm/drivers/macintosh/windfarm_lm75_sensor.c
@@ -39,8 +39,10 @@
 static int wf_lm75_detach(struct i2c_client *client);
 
 static struct i2c_driver wf_lm75_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "wf_lm75",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "wf_lm75",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= wf_lm75_attach,
 	.detach_client	= wf_lm75_detach,

--

