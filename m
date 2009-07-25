From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Sat, 25 Jul 2009 00:43:29 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: Enhance the sysfs API for power
Message-Id: <20090725004328.20709.57712.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

Augment the documentation of the hwmon sysfs API to accomodate ACPI power
meters.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---
 Documentation/hwmon/sysfs-interface |   44 +++++++++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)


diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
index dcbd502..e196701 100644
--- a/Documentation/hwmon/sysfs-interface
+++ b/Documentation/hwmon/sysfs-interface
@@ -357,6 +357,14 @@ power[1-*]_average_interval	Power use averaging interval
 				Unit: milliseconds
 				RW
 
+power[1-*]_average_interval_max	Maximum power use averaging interval
+				Unit: milliseconds
+				RO
+
+power[1-*]_average_interval_min	Minimum power use averaging interval
+				Unit: milliseconds
+				RO
+
 power[1-*]_average_highest	Historical average maximum power use
 				Unit: microWatt
 				RO
@@ -365,6 +373,16 @@ power[1-*]_average_lowest	Historical average minimum power use
 				Unit: microWatt
 				RO
 
+power[1-*]_average_max		A notification is sent when power use
+				rises above this value.
+				Unit: microWatt
+				RW
+
+power[1-*]_average_min		A notification is sent when power use
+				sinks below this value.
+				Unit: microWatt
+				RW
+
 power[1-*]_input		Instantaneous power use
 				Unit: microWatt
 				RO
@@ -381,6 +399,32 @@ power[1-*]_reset_history	Reset input_highest, input_lowest,
 				average_highest and average_lowest.
 				WO
 
+power[1-*]_accuracy		Accuracy of the power meter.
+				Unit: Percent
+				RO
+
+power[1-*]_alarm		1 if the system is drawing more power than the
+				cap allows; 0 otherwise.
+				RO
+
+power[1-*]_cap			If power use rises above this limit, the
+				system should take action to reduce power use.
+				Unit: microWatt
+				RW
+
+power[1-*]_cap_hyst		Margin of hysteresis built around capping and
+				notification.
+				Unit: microWatt
+				RW
+
+power[1-*]_cap_max		Maximum cap that can be set.
+				Unit: microWatt
+				RO
+
+power[1-*]_cap_min		Minimum cap that can be set.
+				Unit: microWatt
+				RO
+
 **********
 * Energy *
 **********


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
