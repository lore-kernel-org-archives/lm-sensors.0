From: Andreas Herrmann <herrmann.der.user@googlemail.com>
Date: Fri, 08 Apr 2011 13:57:46 +0000
Subject: [lm-sensors] [PATCH] hwmon, fam15h_power: Add maintainers entry
Message-Id: <20110408135746.GB12014@alberich.amd.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110404160733.GA11818@alberich.amd.com>
 <20110405144536.GA5054@alberich.amd.com>
 <20110406135424.GC2177@alberich.amd.com>
In-Reply-To: <20110406135424.GC2177@alberich.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Thomas Renninger <trenn@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>

From: Andreas Herrmann <andreas.herrmann3@amd.com>

Signed-off-by: Andreas Herrmann <andreas.herrmann3@amd.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

As suggested by Jean, here's a patch to add a maintainers
entry for the new driver.


Regards,

Andreas

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b4b9cd..af8421d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -483,6 +483,13 @@ F:	drivers/tty/serial/altera_jtaguart.c
 F:	include/linux/altera_uart.h
 F:	include/linux/altera_jtaguart.h
 
+AMD FAM15H PROCESSOR POWER HARDWARE MONITORING DRIVER
+M:	Andreas Herrmann <andreas.herrmann3@amd.com>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/fam15h_power
+F:	drivers/hwmon/fam15h_power.c
+
 AMD GEODE CS5536 USB DEVICE CONTROLLER DRIVER
 M:	Thomas Dahlmann <dahlmann.thomas@arcor.de>
 L:	linux-geode@lists.infradead.org (moderated for non-subscribers)
-- 
1.7.4.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
