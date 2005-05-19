From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: [PATCH] I2C fixes for 2.6.10-rc2
Message-Id: <11018600193699@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11018600183171@kroah.com>
References: <20041119220001.GB15956@kroah.com>
In-Reply-To: <20041119220001.GB15956@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.2223.2.3, 2004/11/24 14:24:57-08:00, johnpol@2ka.mipt.ru

[PATCH] w1: make W1_DS9490_BRIDGE available

W1_DS9490R_BRIDGE kconfig typo.


Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/w1/Kconfig |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/w1/Kconfig b/drivers/w1/Kconfig
--- a/drivers/w1/Kconfig	2004-11-30 16:01:16 -08:00
+++ b/drivers/w1/Kconfig	2004-11-30 16:01:16 -08:00
@@ -30,7 +30,7 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called ds9490r.ko.
 
-config W1_DS9490R_BRIDGE
+config W1_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
 	depends on W1_DS9490
 	help

