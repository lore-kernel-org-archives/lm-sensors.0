From: joe@perches.com
Date: Mon, 13 Aug 2007 06:31:48 +0000
Subject: [lm-sensors] [PATCH] [312/2many] MAINTAINERS - MAX6650 HARDWARE
Message-Id: <46bffad4.XniGtsVMOQCJEtM1%joe@perches.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, hjk@linutronix.de, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index f200501..ab3a4ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3006,6 +3006,8 @@ P:	Hans J. Koch
 M:	hjk@linutronix.de
 L:	lm-sensors@lm-sensors.org
 S:	Maintained
+F:	Documentation/hwmon/max6650
+F:	drivers/hwmon/max6650.c
 
 MEGARAID SCSI DRIVERS
 P:	Neela Syam Kolli

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
