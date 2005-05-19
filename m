From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: [PATCH] i2c driver fixes for 2.6.0
Message-Id: <10728219711770@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10728219711203@kroah.com>
References: <10728219692713@kroah.com>
In-Reply-To: <10728219692713@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1496.8.35, 2003/12/19 11:49:32-08:00, greg@kroah.com

[PATCH] I2C: removed #include <linux/i2c.h> from sa1100_stork.c as it's not needed.

Thanks to Jean Delvare <khali@linux-fr.org> for pointing it out.


 drivers/pcmcia/sa1100_stork.c |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/pcmcia/sa1100_stork.c b/drivers/pcmcia/sa1100_stork.c
--- a/drivers/pcmcia/sa1100_stork.c	Tue Dec 30 12:29:25 2003
+++ b/drivers/pcmcia/sa1100_stork.c	Tue Dec 30 12:29:25 2003
@@ -23,7 +23,6 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/device.h>
-#include <linux/i2c.h>
 
 #include <asm/hardware.h>
 #include <asm/mach-types.h>

