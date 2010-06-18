From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 18 Jun 2010 16:06:34 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: Update MAINTAINERS for smm665 driver
Message-Id: <1276877194-28214-4-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1276877194-28214-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1276877194-28214-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 MAINTAINERS |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d119c9..2e8334d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5205,6 +5205,13 @@ M:	Nicolas Pitre <nico@fluxnic.net>
 S:	Odd Fixes
 F:	drivers/net/smc91x.*
 
+SMM665 HARDWARE MONITOR DRIVER
+M:	"Guenter Roeck" <linux@roeck-us.net>
+L:	lm-sensors@lm-sensors.org
+S:	Maintained
+F:	Documentation/hwmon/smm665
+F:	drivers/hwmon/smm665.c
+
 SMSC47B397 HARDWARE MONITOR DRIVER
 M:	"Mark M. Hoffman" <mhoffman@lightlink.com>
 L:	lm-sensors@lm-sensors.org
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
