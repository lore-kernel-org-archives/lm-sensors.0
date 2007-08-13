From: joe@perches.com
Date: Mon, 13 Aug 2007 06:39:32 +0000
Subject: [lm-sensors] [PATCH] [536/2many] MAINTAINERS - VT8231 HARDWARE
Message-Id: <46bffca4.6Lu3UWtUI5Nk5hzk%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, roger@planbit.co.uk, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 52b7742..3871621 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5064,6 +5064,7 @@ P:	Roger Lucas
 M:	roger@planbit.co.uk
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	drivers/hwmon/vt8231.c
 
 W1 DALLAS'S 1-WIRE BUS
 P:	Evgeniy Polyakov

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
