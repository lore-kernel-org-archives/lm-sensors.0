From: laurent.riffard@free.fr (Laurent riffard)
Date: Mon, 24 Oct 2005 23:31:24 +0000
Subject: [lm-sensors] [patch 8/9] I2C: remove i2c_driver's .owner and .name
Message-Id: <20051024212543.215589000@antares.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_drivers's ones.

This patch updates the drivers for acorn arch.

Signed-off-by: Laurent Riffard <laurent.riffard@free.fr>
--

 drivers/acorn/char/pcf8583.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

Index: linux-2.6-mm/drivers/acorn/char/pcf8583.c
=================================--- linux-2.6-mm.orig/drivers/acorn/char/pcf8583.c
+++ linux-2.6-mm/drivers/acorn/char/pcf8583.c
@@ -221,7 +221,10 @@
 }
 
 static struct i2c_driver pcf8583_driver = {
-	.name		= "PCF8583",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "PCF8583",
+	},
 	.id		= I2C_DRIVERID_PCF8583,
 	.flags		= I2C_DF_NOTIFY,
 	.attach_adapter	= pcf8583_probe,

--

