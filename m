From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 05 Apr 2011 18:40:22 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: Add submitting-patches checklist to
Message-Id: <1302028822-4624-1-git-send-email-guenter.roeck@ericsson.com>
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
v2: Renamed and reorganized document. Added more items and clarifications
    from review feedback.

 Documentation/hwmon/submitting-patches |   83 ++++++++++++++++++++++++++++++++
 1 files changed, 83 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/submitting-patches

diff --git a/Documentation/hwmon/submitting-patches b/Documentation/hwmon/submitting-patches
new file mode 100644
index 0000000..b98c8cd
--- /dev/null
+++ b/Documentation/hwmon/submitting-patches
@@ -0,0 +1,83 @@
+1. General
+
+* It should be unnecessary to mention, but please read and follow 
+    Documentation/SubmitChecklist
+    Documentation/SubmittingDrivers
+    Documentation/SubmittingPatches
+    Documentation/CodingStyle
+
+* If your patch generates checkpatch warnings, please refrain from explanations
+  such as "I don't like that coding style". Keep in mind that each unnecessary
+  warning helps hiding a real problem. If you don't like the kernel coding
+  style, don't write kernel drivers.
+
+* Please test your patch thoroughly. We are not your test group.
+
+* If your patch (or the driver) supports configuration options such as
+  CONFIG_SMP or CONFIG_HOTPLUG, make sure it compiles for all configuration
+  variants.
+
+
+2. Adding functionality to existing drivers
+
+* Make sure the documentation in Documentation/hwmon/<driver_name> is up to
+  date.
+
+* Make sure the information in Kconfig is up to date.
+
+* If the added functionality requires some cleanup or structural changes, split
+  your patch into a cleanup part and the actual addition. This makes it easier
+  to review your changes, and to bisect any resulting problems.
+
+* Never mix bug fixes, cleanup, and functional enhancements in a single patch.
+
+
+3. New drivers
+
+* Running your patch or driver file(s) through checkpatch does not mean its
+  formatting is clean. If unsure about formatting in your new driver, run it
+  through Lindent. Lindent is not perfect, and you may have to do some minor
+  cleanup, but it is a good start.
+
+* Consider adding yourself to MAINTAINERS.
+
+* Document the driver in Documentation/hwmon/<driver_name>.
+
+* Add the driver to Kconfig and Makefile in alphabetical order.
+
+* Make sure that all dependencies are listed in Kconfig. For new drivers, it
+  is most likely prudent to add a dependency on EXPERIMENTAL.
+
+* Avoid forward declarations if you can. Rearrange the code if necessary.
+
+* Avoid calculations in macros and macro-generated functions. While such macros
+  may save a line or so in the source, it obfuscates the code and makes code
+  review more difficult. It may also result in code which is more complicated
+  than necessary. Use inline functions or just regular functions instead.
+
+* If the driver has a detect function, make sure it is silent. Debug messages
+  and messages printed after a successful detection are acceptable, but it
+  must not print messages such as "Chip XXX not found/supported".
+
+  Keep in mind that the detect function will run for all drivers supporting an
+  address if a chip is detected on that address. Unnecessary messages will just
+  pollute the kernel log and not provide any value.
+
+* Avoid writing to chip registers in the _detect function. If you have to write,
+  only do it after you have already gathered enough data to be certain that the
+  detection is going to be successful.
+  
+  Keep in mind that the chip might not be what your driver believes it is, and
+  writing to it might cause a bad misconfiguration.
+
+* Make sure there are no race conditions in the probe function. Specifically,
+  completely initialize your chip first, then create sysfs entries and register
+  with the hwmon subsystem.
+
+* Do not provide deprecated sysfs attributes.
+
+* Do not create non-standard attributes unless really needed. If you have to use
+  non-standard attributes, or you believe you do, discuss it on the mailing list
+  first. Either case, provide a detailed explanation why you need the
+  non-standard attribute(s).
+  Standard attributes are specified in Documentation/hwmon/sysfs-interface.
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
