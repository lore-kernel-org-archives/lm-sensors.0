From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 29 Jan 2008 09:11:14 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: Define sysfs interface for energy
Message-Id: <20080129091114.GI2549@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Expand the hwmon sysfs API to export energy consumption numbers.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/sysfs-interface |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index f4a8ebc..e256bed 100644
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

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
