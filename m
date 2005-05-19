From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567603666@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567602050@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.7, 2004/01/14 11:19:14-08:00, khali@linux-fr.org

[PATCH] I2C: Typo in i2c/busses/Kconfig

Another simple patch for your collection. BTW I don't think that i2c-rpx
can be used in 2.6 since it relies on an algorithm that hasn't been
ported yet.


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:32:11 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:32:11 2004
@@ -187,7 +187,7 @@
 	  will be called i2c-prosavage.
 
 config I2C_RPXLITE
-	tristate "Embedded Planet RPX Lite/Classic suppoort"
+	tristate "Embedded Planet RPX Lite/Classic support"
 	depends on (RPXLITE || RPXCLASSIC) && I2C_ALGO8XX
 
 config I2C_SAVAGE4

