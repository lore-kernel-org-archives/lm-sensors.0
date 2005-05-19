From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567633966@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567633048@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.15, 2004/01/15 16:05:33-08:00, greg@kroah.com

[PATCH] I2C: remove CONFIG_ISA dependancy for I2C_ISA as x86_64 does not have CONFIG_ISA


 drivers/i2c/busses/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:30 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:30:30 2004
@@ -108,7 +108,7 @@
 
 config I2C_ISA
 	tristate "ISA Bus support"
-	depends on I2C && ISA && EXPERIMENTAL
+	depends on I2C && EXPERIMENTAL
 	help
 	  If you say yes to this option, support will be included for i2c
 	  interfaces that are on the ISA bus.

