From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:23 +0000
Subject: [lm-sensors] [patch 7/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212542.827677000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the drivers for ppc arch.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 sound/ppc/keywest.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/sound/ppc/keywest.c
=================================--- linux-2.6-mm.orig/sound/ppc/keywest.c
+++ linux-2.6-mm/sound/ppc/keywest.c
@@ -41,7 +41,10 @@
 static int keywest_detach_client(struct i2c_client *client);
 
 struct i2c_driver keywest_driver = {  
-	.name = "PMac Keywest Audio",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "PMac Keywest Audio",
+	},
 	.id = I2C_DRIVERID_KEYWEST,
 	.flags = I2C_DF_NOTIFY,
 	.attach_adapter = &keywest_attach_adapter,

--

