From: Kamil Debski <k.debski@samsung.com>
Date: Wed, 20 Aug 2014 09:29:23 +0000
Subject: [lm-sensors] [PATCH] MAINTAINERS: add entry for the PWM fan driver
Message-Id: <1408526963-30524-1-git-send-email-k.debski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: linux@roeck-us.net, Kamil Debski <k.debski@samsung.com>

Signed-off-by: Kamil Debski <k.debski@samsung.com>
---
 MAINTAINERS |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 548602f..38e4765 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7244,6 +7244,14 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/pwc/*
 
+PWM FAN DRIVER
+M:	Kamil Debski <k.debski@samsung.com>
+L:	lm-sensors@lm-sensors.org
+S:	Supported
+F:	Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+F:	Documentation/hwmon/pwm-fan
+F:	drivers/hwmon/pwm-fan.c
+
 PWM SUBSYSTEM
 M:	Thierry Reding <thierry.reding@gmail.com>
 L:	linux-pwm@vger.kernel.org
-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
