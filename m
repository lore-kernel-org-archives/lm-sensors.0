From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 09 Oct 2007 20:39:24 +0000
Subject: [lm-sensors] [PATCH v3] hwmon: Add power meter spec
Message-Id: <20071009203923.GJ16752@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Update the hwmon sysfs interface documentation to include a specification
for power meters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 Documentation/hwmon/sysfs-interface |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index db7bb4a..4e0fb20 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -324,6 +324,37 @@ curr[1-*]_input	Current input value
 		Unit: milliampere
 		RO
 
+*********
+* Power *
+*********
+
+power[1-*]_average		Average power use
+				Unit: microWatt
+				RO
+
+power[1-*]_average_highest	Historical average maximum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_average_lowest	Historical average minimum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input		Instantaneous power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input_highest	Historical maximum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_input_lowest		Historical minimum power use
+				Unit: microWatt
+				RO
+
+power[1-*]_reset_history	Reset input_highest, input_lowest,
+				average_highest and average_lowest.
+				WO
 
 **********
 * Alarms *

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
