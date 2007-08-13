From: joe@perches.com
Date: Mon, 13 Aug 2007 06:35:48 +0000
Subject: [lm-sensors] [PATCH] [435/2many] MAINTAINERS - SIS 96X I2C/SMBUS
Message-Id: <46bffbc4./AOzDIg28g0KVR/0%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, mhoffman@lightlink.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index b74e343..761029d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4142,6 +4142,8 @@ P:	Mark M. Hoffman
 M:	mhoffman@lightlink.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/i2c/busses/i2c-sis96x
+F:	drivers/i2c/busses/i2c-sis96x.c
 
 SIS FRAMEBUFFER DRIVER
 P:	Thomas Winischhofer

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
