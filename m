From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 11 Jun 2016 04:03:35 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update guildelines for submitting patches
Message-Id: <1465617815-23785-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hardware Monitoring <linux-hwmon@vger.kernel.org>, Hardware Monitoring <lm-sensors@lm-sensors.org>
Cc: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>

Add more details to the guidelines for submitting patches.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/submitting-patches | 40 +++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches
index d201828d202f..57f60307accc 100644
--- a/Documentation/hwmon/submitting-patches
+++ b/Documentation/hwmon/submitting-patches
@@ -15,10 +15,15 @@ increase the chances of your change being accepted.
     Documentation/SubmittingPatches
     Documentation/CodingStyle
 
-* If your patch generates checkpatch warnings, please refrain from explanations
-  such as "I don't like that coding style". Keep in mind that each unnecessary
-  warning helps hiding a real problem. If you don't like the kernel coding
-  style, don't write kernel drivers.
+* Please run your patch through 'checkpatch --strict'. There should be no
+  errors, no warnings, and few if any check messages. If there are any
+  messages, please be prepared to explain.
+
+* If your patch generates checkpatch errors, warnings, or check messages,
+  please refrain from explanations such as "I prefer that coding style".
+  Keep in mind that each unnecessary message helps hiding a real problem,
+  and a consistent coding style makes it easier for others to understand
+  and review the code.
 
 * Please test your patch thoroughly. We are not your test group.
   Sometimes a patch can not or not completely be tested because of missing
@@ -61,15 +66,30 @@ increase the chances of your change being accepted.
 
 * Make sure that all dependencies are listed in Kconfig.
 
+* Please list include files in alphabetic order.
+
+* Please align continuation lines with '(' on the previous line.
+
 * Avoid forward declarations if you can. Rearrange the code if necessary.
 
+* Avoid macros to generate groups of sensor attributes. It not only confuses
+  checkpatch, but also makes it more difficult to review the code.
+
 * Avoid calculations in macros and macro-generated functions. While such macros
   may save a line or so in the source, it obfuscates the code and makes code
   review more difficult. It may also result in code which is more complicated
   than necessary. Use inline functions or just regular functions instead.
 
+* Limit the number of kernel log messages. In general, your driver should not
+  generate an error message just because a runtime operation failed. Report
+  errors to user space instead, using an appropriate error code. Keep in mind
+  that kernel error log messages not only fill up the kernel log, but also are
+  printed synchronously, most likely with interrupt disabled, often to a serial
+  console. Excessive logging can seriously affect system performance.
+
 * Use devres functions whenever possible to allocate resources. For rationale
   and supported functions, please see Documentation/driver-model/devres.txt.
+  If a function is not supported by devres, consider using devm_add_action().
 
 * If the driver has a detect function, make sure it is silent. Debug messages
   and messages printed after a successful detection are acceptable, but it
@@ -96,8 +116,16 @@ increase the chances of your change being accepted.
   writing to it might cause a bad misconfiguration.
 
 * Make sure there are no race conditions in the probe function. Specifically,
-  completely initialize your chip first, then create sysfs entries and register
-  with the hwmon subsystem.
+  completely initialize your chip and your driver first, then register with
+  the hwmon subsystem.
+
+* Use devm_hwmon_device_register_with_groups() or, if your driver needs a remove
+  function, hwmon_device_register_with_groups() to register your driver with the
+  hwmon subsystem. Try using devm_add_action() instead of a remove function if
+  possible. Do not use hwmon_device_register().
+
+* Your driver should be buildable as module. If not, please be prepared to
+  explain why it has to be built into the kernel.
 
 * Do not provide support for deprecated sysfs attributes.
 
-- 
2.5.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
