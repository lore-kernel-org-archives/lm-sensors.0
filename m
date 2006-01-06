From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:35 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 4 of 11
Message-Id: <11365852551497@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 4 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for macintosh.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Benjamin Herrenschmidt <benh at kernel.crashing.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit a33ca23231a37e28d15da9546b1f3e83dc48284b
tree 50c59c7dfbf77cb9297dd20d2aa1e3958f5f358d
parent cdaf79349c7d24e1d33acb6497849c9e956a33ea
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:40:34 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:23 -0800

 drivers/macintosh/therm_adt746x.c        |    6 ++++--
 drivers/macintosh/therm_pm72.c           |    6 ++++--
 drivers/macintosh/therm_windtunnel.c     |    6 ++++--
 drivers/macintosh/windfarm_lm75_sensor.c |    6 ++++--
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/macintosh/therm_adt746x.c b/drivers/macintosh/therm_adt746x.c
index f62c16f..8bb1d85 100644
--- a/drivers/macintosh/therm_adt746x.c
+++ b/drivers/macintosh/therm_adt746x.c
@@ -171,8 +171,10 @@ detach_thermostat(struct i2c_adapter *ad
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
diff --git a/drivers/macintosh/therm_pm72.c b/drivers/macintosh/therm_pm72.c
index df00c96..97807be 100644
--- a/drivers/macintosh/therm_pm72.c
+++ b/drivers/macintosh/therm_pm72.c
@@ -283,8 +283,10 @@ static int therm_pm72_detach(struct i2c_
 
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
diff --git a/drivers/macintosh/therm_windtunnel.c b/drivers/macintosh/therm_windtunnel.c
index f3bae0d..259f19d 100644
--- a/drivers/macintosh/therm_windtunnel.c
+++ b/drivers/macintosh/therm_windtunnel.c
@@ -354,8 +354,10 @@ do_detach( struct i2c_client *client )
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
diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 2392789..555d0e4 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -47,8 +47,10 @@ static int wf_lm75_attach(struct i2c_ada
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


