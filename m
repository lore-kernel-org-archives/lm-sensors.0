From: joe@perches.com
Date: Mon, 13 Aug 2007 06:35:57 +0000
Subject: [lm-sensors] [PATCH] [440/2many] MAINTAINERS - SMSC47B397 HARDWARE
Message-Id: <46bffbcd.ByWqlMNDQcr1aAxq%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, mhoffman@lightlink.com, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 140eb07..2bda79d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4182,6 +4182,8 @@ P:	Mark M. Hoffman
 M:	mhoffman@lightlink.com
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/smsc47b397
+F:	drivers/hwmon/smsc47b397.c
 
 SOFTMAC LAYER (IEEE 802.11)
 P:	Johannes Berg

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
