From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Feb 2008 09:57:53 +0000
Subject: [lm-sensors] [PATCH] hwmon: Update the sysfs interface documentation
Message-Id: <20080223105753.77ef8382@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070820164444.48e68a63@hyperion.delvare>
In-Reply-To: <20070820164444.48e68a63@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Document the characteristics of libsensors 3.0.0 and 3.0.1.
* The sysfs interface is no longer subject to changes.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/sysfs-interface |   33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

--- linux-2.6.25-rc2.orig/Documentation/hwmon/sysfs-interface	2008-01-25 10:26:47.000000000 +0100
+++ linux-2.6.25-rc2/Documentation/hwmon/sysfs-interface	2008-02-23 10:47:34.000000000 +0100
@@ -2,17 +2,12 @@ Naming and data format standards for sys
 ------------------------------------------------
 
 The libsensors library offers an interface to the raw sensors data
-through the sysfs interface. See libsensors documentation and source for
-further information. As of writing this document, libsensors
-(from lm_sensors 2.8.3) is heavily chip-dependent. Adding or updating
-support for any given chip requires modifying the library's code.
-This is because libsensors was written for the procfs interface
-older kernel modules were using, which wasn't standardized enough.
-Recent versions of libsensors (from lm_sensors 2.8.2 and later) have
-support for the sysfs interface, though.
-
-The new sysfs interface was designed to be as chip-independent as
-possible.
+through the sysfs interface. Since lm-sensors 3.0.0, libsensors is
+completely chip-independent. It assumes that all the kernel drivers
+implement the standard sysfs interface described in this document.
+This makes adding or updating support for any given chip very easy, as
+libsensors, and applications using it, do not need to be modified.
+This is a major improvement compared to lm-sensors 2.
 
 Note that motherboards vary widely in the connections to sensor chips.
 There is no standard that ensures, for example, that the second
@@ -35,19 +30,17 @@ access this data in a simple and consist
 will have to implement conversion, labeling and hiding of inputs. For
 this reason, it is still not recommended to bypass the library.
 
-If you are developing a userspace application please send us feedback on
-this standard.
-
-Note that this standard isn't completely established yet, so it is subject
-to changes. If you are writing a new hardware monitoring driver those
-features can't seem to fit in this interface, please contact us with your
-extension proposal. Keep in mind that backward compatibility must be
-preserved.
-
 Each chip gets its own directory in the sysfs /sys/devices tree.  To
 find all sensor chips, it is easier to follow the device symlinks from
 /sys/class/hwmon/hwmon*.
 
+Up to lm-sensors 3.0.0, libsensors looks for hardware monitoring attributes
+in the "physical" device directory. Since lm-sensors 3.0.1, attributes found
+in the hwmon "class" device directory are also supported. Complex drivers
+(e.g. drivers for multifunction chips) may want to use this possibility to
+avoid namespace pollution. The only drawback will be that older versions of
+libsensors won't support the driver in question.
+
 All sysfs values are fixed point numbers.
 
 There is only one value per file, unlike the older /proc specification.


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
