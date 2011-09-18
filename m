From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 18 Sep 2011 19:25:12 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon: Add notification and uevent support
Message-Id: <1316373912-10041-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some hwmon drivers start adding support for alarm attribute notifications and
generate uevents. Standardize the ABI to be used for this purpose.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
An attempt to standardize notification and uevent support for hwmon drivers.

 Documentation/hwmon/sysfs-interface |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index e65e7e8..735d33f 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -97,6 +97,16 @@ update_interval	The interval at which the chip will update readings.
 		Some devices have a variable update rate or interval.
 		This attribute can be used to change it to the desired value.
 
+notification	This attribute exists if the driver supports notifications on
+		alarm and trigger attributes. Valid attribute values are:
+		0: The driver does not support notifications or uevents.
+		1: The driver supports notifications.
+		2: The driver generates a uevent if an alarm or trigger status
+		   changes.
+		3: The driver suports notifications and generates a uevent if
+		   an alarm or trigger status changes.
+		RO
+
 
 ************
 * Voltages *
@@ -706,6 +716,26 @@ intrusion[0-*]_beep
 		RW
 
 
+Notifications and uevents
+-------------------------
+
+Hwmon drivers may support generating notification on sysfs alarm and trigger
+attributes. This support is reflected in the existence of the "notification"
+attribute described above.
+
+If a driver supports notifications, applications do not have to manually poll
+alarm and trigger attributes, but can use poll(2) or epoll(4) instead.
+
+If a driver supports notifications, it shall support it for all alarm and
+trigger attributes. Notifications shall be generated for all state transistions
+(0->1 as well as 1->0).
+
+In addition to notifications, drivers may also support uevents. If so, a uevent
+shall be triggered whenever an alarm or trigger attribute changes its state.
+The uevent shall be triggered on the driver's hwmon device kobject
+(TBD: on the platform device kobject ?).
+
+
 sysfs attribute writes interpretation
 -------------------------------------
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
