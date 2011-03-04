From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 04 Mar 2011 17:58:06 +0000
Subject: [lm-sensors] [PATCH v5 11/11] hwmon: (w83627ehf) Update Kconfig for
Message-Id: <1299261486-15190-12-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1299261486-15190-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Ian Dobson <i.dobson@planet-ian.com>, Andy Lutomirski <luto@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, binximeng@gmail.com, lmsensors@tapanitarvainen.fi, andrea.rizzolo@gmail.com, jeff.sadowski@gmail.com, lm-sensors@lm-sensors.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/Kconfig |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 297bc9a..c100802 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1083,7 +1083,7 @@ config SENSORS_W83627HF
 	  will be called w83627hf.
 
 config SENSORS_W83627EHF
-	tristate "Winbond W83627EHF/EHG/DHG, W83667HG"
+	tristate "Winbond W83627EHF/EHG/DHG, W83667HG, NCT6775F, NCT6776F"
 	select HWMON_VID
 	help
 	  If you say yes here you get support for the hardware
@@ -1094,7 +1094,8 @@ config SENSORS_W83627EHF
 	  chip suited for specific Intel processors that use PECI such as
 	  the Core 2 Duo.
 
-	  This driver also supports the W83667HG chip.
+	  This driver also supports Nuvoton W83667HG, W83667HG-B, NCT6775F
+	  (also known as W83667HG-I), and NCT6776F.
 
 	  This driver can also be built as a module.  If so, the module
 	  will be called w83627ehf.
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
