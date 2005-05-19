From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: [PATCH] i2c driver fixes for 2.6.1
Message-Id: <10745567602050@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10745567592337@kroah.com>
References: <1074556757661@kroah.com>
In-Reply-To: <1074556757661@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1474.98.6, 2004/01/14 11:13:34-08:00, khali@linux-fr.org

[PATCH] I2C: saa7146.h doesn't need i2c.h


 drivers/media/video/saa7146.h |    1 -
 1 files changed, 1 deletion(-)


diff -Nru a/drivers/media/video/saa7146.h b/drivers/media/video/saa7146.h
--- a/drivers/media/video/saa7146.h	Mon Jan 19 15:32:24 2004
+++ b/drivers/media/video/saa7146.h	Mon Jan 19 15:32:24 2004
@@ -25,7 +25,6 @@
 #include <linux/types.h>
 #include <linux/wait.h>
 
-#include <linux/i2c.h>
 #include <linux/videodev.h>
 
 #ifndef O_NONCAP  

