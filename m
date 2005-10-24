From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:19 +0000
Subject: [lm-sensors] [patch 6/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212542.275966000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the OSS drivers.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 sound/oss/dmasound/dac3550a.c   |    6 ++++--
 sound/oss/dmasound/tas_common.c |    6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

Index: linux-2.6-mm/sound/oss/dmasound/dac3550a.c
=================================--- linux-2.6-mm.orig/sound/oss/dmasound/dac3550a.c
+++ linux-2.6-mm/sound/oss/dmasound/dac3550a.c
@@ -41,8 +41,10 @@
 static int daca_detach_client(struct i2c_client *client);
 
 struct i2c_driver daca_driver = {  
-	.owner			= THIS_MODULE,
-	.name			= "DAC3550A driver  V " DACA_VERSION,
+	.driver = {
+		.owner		= THIS_MODULE,
+		.name		= "DAC3550A driver  V " DACA_VERSION,
+	},
 	.id			= I2C_DRIVERID_DACA,
 	.flags			= I2C_DF_NOTIFY,
 	.attach_adapter		= daca_attach_adapter,
Index: linux-2.6-mm/sound/oss/dmasound/tas_common.c
=================================--- linux-2.6-mm.orig/sound/oss/dmasound/tas_common.c
+++ linux-2.6-mm/sound/oss/dmasound/tas_common.c
@@ -47,8 +47,10 @@
 static int tas_detach_client(struct i2c_client *);
 
 struct i2c_driver tas_driver = {
-	.owner		= THIS_MODULE,
-	.name		= "tas",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "tas",
+	},
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= tas_attach_adapter,
 	.detach_client	= tas_detach_client,

--

