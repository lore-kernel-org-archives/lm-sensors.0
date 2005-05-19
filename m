From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <10609724081720@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10609724071636@kroah.com>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1123.18.6, 2003/08/14 14:31:21-07:00, rusty@linux.co.intel.com

[PATCH] I2C: bugfix for initialization bug in adm1021 driver

While initializing the adm1021 device, the driver is performing a conversion
from fixed point to Celcius on values that were declaired as Celcius.  On
my Dell Precision 220 this results in a shutdown after a couple of minutes
running.

This is a very simple patch against the 2.6.0-test3 tree that just removes the
conversion.


 drivers/i2c/chips/adm1021.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
+++ b/drivers/i2c/chips/adm1021.c	Fri Aug 15 11:26:53 2003
@@ -356,13 +356,13 @@
 {
 	/* Initialize the adm1021 chip */
 	adm1021_write_value(client, ADM1021_REG_TOS_W,
-			    TEMP_TO_REG(adm1021_INIT_TOS));
+			    adm1021_INIT_TOS);
 	adm1021_write_value(client, ADM1021_REG_THYST_W,
-			    TEMP_TO_REG(adm1021_INIT_THYST));
+			    adm1021_INIT_THYST);
 	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
-			    TEMP_TO_REG(adm1021_INIT_REMOTE_TOS));
+			    adm1021_INIT_REMOTE_TOS);
 	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
-			    TEMP_TO_REG(adm1021_INIT_REMOTE_THYST));
+			    adm1021_INIT_REMOTE_THYST);
 	/* Enable ADC and disable suspend mode */
 	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
 	/* Set Conversion rate to 1/sec (this can be tinkered with) */

