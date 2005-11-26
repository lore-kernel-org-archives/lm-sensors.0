From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:47:34 +0000
Subject: [lm-sensors] [PATCH 16/25] i2c: Drop i2c_driver.{owner, name},
Message-Id: <20051126204835.38fb0268.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Laurent Riffard <laurent.riffard@free.fr>
Content-Disposition: inline; filename=i2c-drop-driver-owner-and-name-07-ppc.patch

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for ppc arch.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 sound/ppc/keywest.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.14-rc5.orig/sound/ppc/keywest.c	2005-10-25 20:45:03.000000000 +0200
+++ linux-2.6.14-rc5/sound/ppc/keywest.c	2005-10-25 21:02:06.000000000 +0200
@@ -41,7 +41,10 @@
 static int keywest_detach_client(struct i2c_client *client);
 
 struct i2c_driver keywest_driver = {  
-	.name = "PMac Keywest Audio",
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "PMac Keywest Audio",
+	},
 	.id = I2C_DRIVERID_KEYWEST,
 	.attach_adapter = &keywest_attach_adapter,
 	.detach_client = &keywest_detach_client,

-- 
Jean Delvare
