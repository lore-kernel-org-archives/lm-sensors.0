From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <1074556764412@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567642211@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.18, 2004/01/16 14:12:54-08:00, khali@linux-fr.org

[PATCH] I2C: i2c-i801 help


 drivers/i2c/busses/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Jan 19 15:29:51 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Jan 19 15:29:51 2004
@@ -73,12 +73,13 @@
 	help
 	  If you say yes to this option, support will be included for the Intel
 	  801 family of mainboard I2C interfaces.  Specifically, the following
-	  versions of the chipset is supported:
+	  versions of the chipset are supported:
 	    82801AA
 	    82801AB
 	    82801BA
 	    82801CA/CAM
 	    82801DB
+	    82801EB
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.

