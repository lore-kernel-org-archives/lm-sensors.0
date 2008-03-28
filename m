From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Fri, 28 Mar 2008 21:36:46 +0000
Subject: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem driver
Message-Id: <20080328213646.GC7191@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Update sysfs interface documentation to include energy meters and power
meter averaging intervals.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/sysfs-interface |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index f4a8ebc..85e6654 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -328,6 +328,14 @@ curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
 
+**********
+* Energy *
+**********
+
+energy[1-*]_input		Instantaneous energy use
+				Unit: microJoule
+				RO
+
 *********
 * Power *
 *********
@@ -336,6 +344,10 @@ power[1-*]_average		Average power use
 				Unit: microWatt
 				RO
 
+power[1-*]_interval		Power use averaging interval
+				Unit: milliseconds
+				RW
+
 power[1-*]_average_highest	Historical average maximum power use
 				Unit: microWatt
 				RO

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
