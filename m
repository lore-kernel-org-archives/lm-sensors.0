From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [PATCH] i2c driver fixes for 2.6.4
Message-Id: <10793913904022@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10793913905@kroah.com>
References: <10793913903814@kroah.com>
In-Reply-To: <10793913903814@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1557.61.5, 2004/02/17 14:42:07-08:00, bunk@fs.tum.de

[PATCH] I2C: update I2C help text

VIDEO_BT848 selects I2C_ALGOBIT.


 drivers/i2c/Kconfig |    3 ---
 1 files changed, 3 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Mon Mar 15 14:37:36 2004
+++ b/drivers/i2c/Kconfig	Mon Mar 15 14:37:36 2004
@@ -15,9 +15,6 @@
 
 	  Both I2C and SMBus are supported here. You will need this for
 	  hardware sensors support, and also for Video For Linux support.
-	  Specifically, if you want to use a BT848 based frame grabber/overlay
-	  boards under Linux, say Y here and also to "I2C bit-banging
-	  interfaces", below.
 
 	  If you want I2C support, you should say Y here and also to the
 	  specific driver for your bus adapter(s) below.

