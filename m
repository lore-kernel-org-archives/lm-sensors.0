From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Apr 2011 15:58:37 +0000
Subject: [lm-sensors] [RFC PATCH] hwmon: Add SubmittingHwmonPatches to
Message-Id: <1301760379-13038-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When writing hardware monitoring drivers, there are some common pitfalls which
keep coming up in code reviews. This patch provides a document describing all
those pitfalls and how to avoid them.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/SubmittingHwmonPatches |   58 ++++++++++++++++++++++++++++
 1 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/SubmittingHwmonPatches

diff --git a/Documentation/hwmon/SubmittingHwmonPatches b/Documentation/hwmon/SubmittingHwmonPatches
new file mode 100644
index 0000000..867f383
--- /dev/null
+++ b/Documentation/hwmon/SubmittingHwmonPatches
@@ -0,0 +1,58 @@
+* It should be unnecessary to mention, but please read and follow 
+    Documentation/SubmitChecklist
+    Documentation/SubmittingDrivers
+    Documentation/SubmittingPatches
+    Documentation/CodingStyle
+
+* Running your patch through checkpatch does not mean its formatting is clean.
+  If unsure about indentation in your new driver, run it through Lindent.
+  Lindent is not perfect, and you may have to do some minor cleanup, but it is a
+  good start.
+
+* If you do have checkpatch warnings, please refrain from explanations such as
+  "I don't like that coding style". Keep in mind that each unnecessary warning
+  helps hiding a real problem. If you don't like the kernel coding style, don't
+  write kernel drivers.
+
+* If you add a new driver, consider adding yourself to MAINTAINERS.
+
+* Document new drivers in Documentation/hwmon/<Driver_Name>. If you add
+  functionality to an existing driver, make sure the documentation is up to date.
+
+* When updating an existing driver, make sure the information in Kconfig is up
+  to date.
+
+* When adding a new driver, add it to Kconfig and Makefile in alphabetical
+  order.
+
+* Make sure there are no race conditions in the probe function. Specifically,
+  initialize your chip first, then create sysfs entries, then register with the
+  hwmon subsystem.
+
+* If your driver has a detect function, make sure it is silent. Specifically, it
+  should not create messages such as "Chip XXX not found/supported". Keep in
+  mind that the detect function will run on all detected chips. Unnecessary
+  messages will just pollute the kernel log and not provide any value.
+
+* Do not write to chip registers in the _detect function. Keep in mind that the
+  chip might not be what your driver believes it is, and writing to it might
+  cause a bad misconfiguration.
+
+* Avoid forward declarations if you can. Rearrange the code if necessary.
+
+* Avoid function macros. While it may save a line or so in the source, it
+  obfuscates the code and makes code review more difficult. It may also result
+  in code which is more complicated than necessary.
+
+* When writing a new driver, do not provide deprecated sysfs attributes.
+
+* Do not create non-ABI attributes unless really needed. If you have to use
+  non-ABI attributes, or you believe you do, discuss it on the mailing list
+  first. Either case, provide a detailed explanation why you need the non-ABI
+  attribute(s).
+  For reference, the ABI is in specified in Documentation/hwmon/sysfs-interface.
+
+* If you add functionality to an existing driver, and the addition requires some
+  cleanup or structural changes, split your patch into a cleanup part and the
+  actual addition. This makes it easier to review your changes, and to bisect
+  any resulting problems.
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
