From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 28 Jun 2010 21:56:54 +0000
Subject: [lm-sensors] [PATCH/RFC 4/4] hwmon: sysfs API updates
Message-Id: <1277762214-15155-5-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1277762214-15155-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1277762214-15155-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Randy Dunlap <rdunlap@xenotime.net>, Andrew Morton <akpm@linux-foundation.org>, "Ira W. Snyder" <iws@ovro.caltech.edu>, "Darrick J. Wong" <djwong@us.ibm.com>, "Ben Dooks (embedded platforms)" <ben-linux@fluff.org>, Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, Crane Cai <crane.cai@amd.com>, Linus Walleij <linus.walleij@stericsson.com>, Ralf Baechle <ralf@linux-mips.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, Guenter Roeck <guenter.roeck@ericsson.com>

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/sysfs-interface |   27 ++++++++++++++++++++++-----
 1 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index d4e2917..b183d94 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -421,11 +421,12 @@ power[1-*]_accuracy		Accuracy of the power meter.
 				Unit: Percent
 				RO
 
-power[1-*]_alarm		1 if the system is drawing more power than the
-				cap allows; 0 otherwise.  A poll notification is
-				sent to this file when the power use exceeds the
-				cap.  This file only appears if the cap is known
-				to be enforced by hardware.
+power[1-*]_alarm		1 if the system is drawing more power than cap
+				or max allows; 0 otherwise.  A poll notification
+				is sent to this file when the power use exceeds
+				the cap or max limit. If only cap is supported,
+				this file only appears if the cap is known to be
+				enforced by hardware.
 				RO
 
 power[1-*]_cap			If power use rises above this limit, the
@@ -450,6 +451,18 @@ power[1-*]_cap_min		Minimum cap that can be set.
 				Unit: microWatt
 				RO
 
+power[1-*]_max			Maximum power.
+				Unit: microWatt
+				RW
+
+power[1-*]_crit			Critical maximum power.
+				If power rises to or above this limit, the
+				system will take drastic action to reduce power
+				consumption, such as a system shutdown. At the
+				very least, a power fault will be generated.
+				Unit: microWatt
+				RO
+
 **********
 * Energy *
 **********
@@ -471,6 +484,7 @@ limit-related alarms, not both. The driver should just reflect the hardware
 implementation.
 
 in[0-*]_alarm
+power[1-*]_alarm
 fan[1-*]_alarm
 temp[1-*]_alarm
 		Channel alarm
@@ -482,6 +496,8 @@ OR
 
 in[0-*]_min_alarm
 in[0-*]_max_alarm
+power[1-*]_min_alarm
+power[1-*]_max_alarm
 fan[1-*]_min_alarm
 fan[1-*]_max_alarm
 temp[1-*]_min_alarm
@@ -498,6 +514,7 @@ supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
 in[0-*]_fault
+power[1-*]_fault
 fan[1-*]_fault
 temp[1-*]_fault
 		Input fault condition
-- 
1.7.0.87.g0901d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
