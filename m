From: bunk@stusta.de (Adrian Bunk)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: [2.6 patch] make W1_DS9490_BRIDGE available
Message-Id: <20041122155102.GD19419@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org

It seems noone noted that due to a typo, the W1_DS9490_BRIDGE option 
didn't have any effect.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig.old	2004-11-22 14:34:13.000000000 +0100
+++ linux-2.6.10-rc2-mm3-full/drivers/w1/Kconfig	2004-11-22 14:34:21.000000000 +0100
@@ -30,7 +30,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called ds9490r.ko.
 
-config W1_DS9490R_BRIDGE
+config W1_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help
