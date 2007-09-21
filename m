From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 21 Sep 2007 15:03:32 +0000
Subject: [lm-sensors] PATCH:
Message-Id: <46F3DD44.4070307@hhs.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010604070703030701070001"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010604070703030701070001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

Here is a patch adding some text to the sysfs interface documentation on how
settings written to sysfs attributes should be handled, focussing mainly on
error handling. This version incorperates Jean's latest comments.

signed-off-by: j.w.r.degoede@hhs.nl

Regards,

Hans

--------------010604070703030701070001
Content-Type: text/x-patch;
	name="documentation-hwmon-sysfs-interface-attr-write.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="documentation-hwmon-sysfs-interface-attr-write.patch"

Here is a patch adding some text to the sysfs interface documentation on how
settings written to sysfs attributes should be handled, focussing mainly on
error handling. This version incorperates Jean's latest comments.

signed-off-by: j.w.r.degoede@hhs.nl
diff -ur linux-2.6.23-rc6.git4/Documentation.orig/hwmon/sysfs-interface linux-2.6.23-rc6.git4/Documentation/hwmon/sysfs-interface
--- linux-2.6.23-rc6.git4/Documentation.orig/hwmon/sysfs-interface	2007-09-21 15:33:10.000000000 +0200
+++ linux-2.6.23-rc6.git4/Documentation/hwmon/sysfs-interface	2007-09-21 16:55:09.000000000 +0200
@@ -67,6 +67,10 @@
 alarm (for example, whether a threshold must be met or must be exceeded
 to cause an alarm) is chip-dependent.
 
+When setting values of hwmon sysfs attributes, the string representation of
+the desired value must be written, note that strings which are not a number
+are interpreted as 0! For more on how written strings are interpreted see the
+"sysfs attribute writes interpretation" section at the end of this file.
 
 -------------------------------------------------------------------------
 
@@ -404,3 +408,57 @@
 		0: disable
 		1: enable
 		RW
+
+
+sysfs attribute writes interpretation
+-------------------------------------
+
+hwmon sysfs attributes always contain numbers, so the first thing to do is to
+convert the input to a number, there are 2 ways todo this depending whether
+the number can be negative or not:
+unsigned long u = simple_strtoul(buf, NULL, 10);
+long s = simple_strtol(buf, NULL, 10);
+
+With buf being the buffer with the user input being passed by the kernel.
+Notice that we do not use the second argument of strto[u]l, and thus cannot
+tell when 0 is returned, if this was really 0 or is caused by invalid input.
+This is done deliberately as checking this everywhere would add a lot of
+code to the kernel.
+
+Notice that it is important to always store the converted value in an
+unsigned long or long, so that no wrap around can happen before any further
+checking.
+
+After the input string is converted to an (unsigned) long, the value should be
+checked if its acceptable. Be careful with further conversions on the value
+before checking it for validity, as these conversions could still cause a wrap
+around before the check. For example do not multiply the result, and only
+add/subtract if it has been divided before the add/subtract.
+
+What to do if a value is found to be invalid, depends on the type of the
+sysfs attribute that is being set. If it is a continuous setting like a
+tempX_max or inX_max attribute, then the value should be clamped to its
+limits using SENSORS_LIMIT(value, min_limit, max_limit). If it is not
+continuous like for example a tempX_type, then when an invalid value is
+written, -EINVAL should be returned.
+
+Example1, temp1_max, register is a signed 8 bit value (-128 - 127 degrees):
+--- begin code ---
+long v = simple_strtol(buf, NULL, 10) / 1000;
+SENSORS_LIMIT(v, -128, 127);
+/* write v to register */
+--- end code ---
+
+Example2, fan divider setting, valid values 2, 4 and 8:
+--- begin code ---
+unsigned long v = simple_strtoul(buf, NULL, 10);
+
+switch (v) {
+       case 2: v = 1; break;
+       case 4: v = 2; break;
+       case 8: v = 3; break;
+       default:
+               return -EINVAL;
+}
+/* write v to register */
+--- end code ---

--------------010604070703030701070001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010604070703030701070001--

