From: gregkh@suse.de (Greg KH)
Date: Fri, 06 Jan 2006 22:07:37 +0000
Subject: [lm-sensors] [PATCH] i2c: Drop i2c_driver.{owner,name}, 8 of 11
Message-Id: <1136585257321@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <11365852541748@kroah.com>
In-Reply-To: <11365852541748@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[PATCH] i2c: Drop i2c_driver.{owner,name}, 8 of 11

We should use the i2c_driver.driver's .name and .owner fields
instead of the i2c_driver's ones.

This patch updates the drivers for acorn arch.

Signed-off-by: Laurent Riffard <laurent.riffard at free.fr>
Signed-off-by: Jean Delvare <khali at linux-fr.org>
Acked-by: Russell King <rmk+kernel at arm.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
commit e533449d291b5a28ce9527539750a0cb88146f6e
tree d7b7045a247276594846bddd073c46f34f3e02a5
parent e100fe103e679372b3d1d6e9d32fd3ab57484be2
author Laurent Riffard <laurent.riffard at free.fr> Sat, 26 Nov 2005 20:51:06 +0100
committer Greg Kroah-Hartman <gregkh at suse.de> Thu, 05 Jan 2006 22:16:24 -0800

 drivers/acorn/char/pcf8583.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/acorn/char/pcf8583.c b/drivers/acorn/char/pcf8583.c
index befc946..5fc5940 100644
--- a/drivers/acorn/char/pcf8583.c
+++ b/drivers/acorn/char/pcf8583.c
@@ -257,7 +257,10 @@ pcf8583_command(struct i2c_client *clien
 }
 
 static struct i2c_driver pcf8583_driver = {
-	.name		= "PCF8583",
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= "PCF8583",
+	},
 	.id		= I2C_DRIVERID_PCF8583,
 	.attach_adapter	= pcf8583_probe,
 	.detach_client	= pcf8583_detach,


