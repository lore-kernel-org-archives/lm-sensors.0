From: bunk@stusta.de (Adrian Bunk)
Date: Sun, 09 Apr 2006 11:31:10 +0000
Subject: [lm-sensors] [-mm patch] drivers/w1/w1.c: fix a compile error
Message-Id: <20060409113110.GA8454@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060408031405.5e5131da.akpm@osdl.org>
In-Reply-To: <20060408031405.5e5131da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, gregkh@suse.de, johnpol@2ka.mipt.ru
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

This patch fixes the following compile error:

<--  snip  -->

...
  CC      drivers/w1/w1.o
drivers/w1/w1.c:197: error: static declaration of 'w1_bus_type' follows non-static declaration
drivers/w1/w1.h:217: error: previous declaration of 'w1_bus_type' was here
make[2]: *** [drivers/w1/w1.o] Error 1

<--  snip  -->

Signed-off-by: Adrian Bunk <bunk at stusta.de>

--- linux-2.6.17-rc1-mm2-full/drivers/w1/w1.h.old	2006-04-09 11:21:48.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/drivers/w1/w1.h	2006-04-09 11:21:57.000000000 +0200
@@ -214,7 +214,6 @@
 }
 
 extern struct device_driver w1_master_driver;
-extern struct bus_type w1_bus_type;
 extern struct device w1_master_device;
 extern int w1_max_slave_count;
 extern int w1_max_slave_ttl;


