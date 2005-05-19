From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH 2.6] I2C: macintoch/therm_* drivers cleanups
Message-Id: <20041129231855.5e7f0bed.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, LKML <linux-kernel@vger.kernel.org>

Hi Greg,

This patch cleans the macintoch/therm_* drivers a bit. It removes
useless IDs, cleans names (no white space), some coding style fixes as
well, etc. It's exactly the same as what I posted yesterday as a
candidate fix to bug #3823:
http://bugzilla.kernel.org/show_bug.cgi?id823

Although it isn't the proper fix for that bug, as you underlined, this
still sounds like a sane set of cleanups for these drivers.

Please apply,
thanks.

Signed-off-by: Jean Delvare <khali@linux-fr.org>

diff -ruN linux-2.6.10-rc2/drivers/macintosh.orig/therm_adt746x.c linux-2.6.10-rc2/drivers/macintosh/therm_adt746x.c
--- linux-2.6.10-rc2/drivers/macintosh.orig/therm_adt746x.c	2004-11-28 11:32:54.000000000 +0100
+++ linux-2.6.10-rc2/drivers/macintosh/therm_adt746x.c	2004-11-28 15:19:54.000000000 +0100
@@ -169,11 +169,11 @@
 }
 
 static struct i2c_driver thermostat_driver = {  
-	.name		="Apple Thermostat ADT746x",
-	.id		=0xDEAD7467,
-	.flags		=I2C_DF_NOTIFY,
-	.attach_adapter	=&attach_thermostat,
-	.detach_adapter	=&detach_thermostat,
+	.owner		= THIS_MODULE,
+	.name		= "therm_adt746x",
+	.flags		= I2C_DF_NOTIFY,
+	.attach_adapter	= attach_thermostat,
+	.detach_adapter	= detach_thermostat,
 };
 
 static int read_fan_speed(struct thermostat *th, u8 addr)
@@ -380,7 +380,6 @@
 	th->clt.addr = addr;
 	th->clt.adapter = adapter;
 	th->clt.driver = &thermostat_driver;
-	th->clt.id = 0xDEAD7467;
 	strcpy(th->clt.name, "thermostat");
 
 	rc = read_reg(th, 0);
diff -ruN linux-2.6.10-rc2/drivers/macintosh.orig/therm_pm72.c linux-2.6.10-rc2/drivers/macintosh/therm_pm72.c
--- linux-2.6.10-rc2/drivers/macintosh.orig/therm_pm72.c	2004-11-28 11:32:54.000000000 +0100
+++ linux-2.6.10-rc2/drivers/macintosh/therm_pm72.c	2004-11-28 13:43:25.000000000 +0100
@@ -235,8 +235,8 @@
 
 static struct i2c_driver therm_pm72_driver  {
+	.owner		= THIS_MODULE,
 	.name		= "therm_pm72",
-	.id		= 0xDEADBEEF,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= therm_pm72_attach,
 	.detach_adapter	= therm_pm72_detach,
@@ -266,7 +266,6 @@
 	clt->addr = (id >> 1) & 0x7f;
 	clt->adapter = adap;
 	clt->driver = &therm_pm72_driver;
-	clt->id = 0xDEADBEEF;
 	strncpy(clt->name, name, I2C_NAME_SIZE-1);
 
 	if (i2c_attach_client(clt)) {
diff -ruN linux-2.6.10-rc2/drivers/macintosh.orig/therm_windtunnel.c linux-2.6.10-rc2/drivers/macintosh/therm_windtunnel.c
--- linux-2.6.10-rc2/drivers/macintosh.orig/therm_windtunnel.c	2004-10-24 09:48:16.000000000 +0200
+++ linux-2.6.10-rc2/drivers/macintosh/therm_windtunnel.c	2004-11-28 15:19:42.000000000 +0100
@@ -353,12 +353,12 @@
 }
 
 static struct i2c_driver g4fan_driver = {  
-	.name		= "Apple G4 Thermostat/Fan",
+	.owner		= THIS_MODULE,
+	.name		= "therm_windtunnel",
 	.id		= I2C_DRIVERID_G4FAN,
 	.flags		= I2C_DF_NOTIFY,
-	.attach_adapter = &do_attach,
-	.detach_client	= &do_detach,
-	.command	= NULL,
+	.attach_adapter = do_attach,
+	.detach_client	= do_detach,
 };
 
 static int


-- 
Jean Delvare
http://khali.linux-fr.org/
