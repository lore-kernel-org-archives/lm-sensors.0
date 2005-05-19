From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test1
Message-Id: <105863009030@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20030719155233.GA11754@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1310.80.1, 2003/06/24 14:58:09-07:00, nikkne@hotpop.com

[PATCH] I2C: fix Kconfig info


 drivers/i2c/Kconfig |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)


diff -Nru a/drivers/i2c/Kconfig b/drivers/i2c/Kconfig
--- a/drivers/i2c/Kconfig	Sat Jul 19 08:48:43 2003
+++ b/drivers/i2c/Kconfig	Sat Jul 19 08:48:43 2003
@@ -20,9 +20,7 @@
 	  interfaces", below.
 
 	  If you want I2C support, you should say Y here and also to the
-	  specific driver for your bus adapter(s) below.  If you say Y to
-	  "/proc file system" below, you will then get a /proc interface which
-	  is documented in <file:Documentation/i2c/proc-interface>.
+	  specific driver for your bus adapter(s) below.
 
 	  This I2C support is also available as a module.  If you want to
 	  compile it as a module, say M here and read

