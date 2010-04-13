From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Tue, 13 Apr 2010 22:54:27 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: add description of the update_rate
Message-Id: <1271199268-3180-2-git-send-email-iws@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-2-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The update_rate attribute can be used by drivers to let userspace choose
the update rate of the chip, if it is configurable.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 Documentation/hwmon/sysfs-interface |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index 3de6b0b..39e9844 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -92,6 +92,18 @@ name		The chip name.
 		RO
 
 
+***************
+* Update Rate *
+***************
+
+update_rate	The rate at which the chip will update readings.
+		Unit: millisecond
+		RW
+		Some devices have a variable update rate. This attribute
+		can be used to change the update rate to the desired
+		frequency.
+
+
 ************
 * Voltages *
 ************
-- 
1.5.4.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
