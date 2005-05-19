From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567661565@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567661358@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.25, 2004/01/19 13:10:24-08:00, greg@kroah.com

[PATCH] I2C: only select I2C_ITE if we are a MIPS system


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:21 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:28:21 2004
@@ -122,7 +122,7 @@
 
 config I2C_ITE
 	tristate "ITE I2C Adapter"
-	depends on I2C
+	depends on I2C && MIPS_ITE8172
 	select I2C_ALGOITE
 	help
 	  This supports the ITE8172 I2C peripheral found on some MIPS

