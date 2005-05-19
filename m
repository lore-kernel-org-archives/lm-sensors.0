From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567633048@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1074556763161@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.14, 2004/01/15 10:34:52-08:00, greg@kroah.com

[PATCH] I2C: move the Kconfig "source..." out of the drivers/char/ location


 drivers/Kconfig      |    2 ++
 drivers/char/Kconfig |    2 --
 2 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/Kconfig b/drivers/Kconfig
--- a/drivers/Kconfig	Mon Jan 19 15:30:43 2004
+++ b/drivers/Kconfig	Mon Jan 19 15:30:43 2004
@@ -38,6 +38,8 @@
 
 source "drivers/char/Kconfig"
 
+source "drivers/i2c/Kconfig"
+
 # source "drivers/misc/Kconfig"
 
 source "drivers/media/Kconfig"
diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
--- a/drivers/char/Kconfig	Mon Jan 19 15:30:43 2004
+++ b/drivers/char/Kconfig	Mon Jan 19 15:30:43 2004
@@ -588,8 +588,6 @@
 	bool "Support for console on line printer"
 	depends on PC9800_OLDLP
 
-source "drivers/i2c/Kconfig"
-
 
 menu "Mice"
 

