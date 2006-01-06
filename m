From: bunk@stusta.de (Adrian Bunk)
Date: Fri, 06 Jan 2006 17:41:01 +0000
Subject: [lm-sensors] [-mm patch] fix W1_MASTER_DS9490_BRIDGE dependencies
Message-Id: <20060106174101.GT12131@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: johnpol@2ka.mipt.ru, gregkh@suse.de
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

W1_DS9490 was renamed to W1_MASTER_DS9490, but the entry in the 
dependencies of W1_MASTER_DS9490_BRIDGE was forgotten.


Signed-off-by: Adrian Bunk <bunk at stusta.de>

--- linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig.old	2006-01-06 18:17:23.000000000 +0100
+++ linux-2.6.15-mm1-full/drivers/w1/masters/Kconfig	2006-01-06 18:17:53.000000000 +0100
@@ -26,7 +26,7 @@
 
 config W1_MASTER_DS9490_BRIDGE
 	tristate "DS9490R USB <-> W1 transport layer for 1-wire"
-	depends on W1_DS9490
+	depends on W1_MASTER_DS9490
 	help
 	  Say Y here if you want to communicate with your 1-wire devices
 	  using DS9490R USB bridge.


