From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 13 Mar 2008 22:12:46 +0000
Subject: [lm-sensors] [PATCH] ibmpex: Report temperatures in mC, not C.
Message-Id: <20080313221245.GI5529@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Andrew Morton <akpm@linux-foundation.org>

ibmpex's temperature sensors report incorrect units.  Apply
a conversion factor so that tempertures report correctly.
Until now, no systems seemed to report temperatures this
way, but evidently QS2x blades do.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmpex.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index db551d8..4e9b19c 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -410,7 +410,7 @@ static int ibmpex_find_sensors(struct ibmpex_bmc_data *data)
 			sensor_type = TEMP_SENSOR;
 			num_temp++;
 			sensor_counter = num_temp;
-			data->sensors[i].multiplier = 1;
+			data->sensors[i].multiplier = 1000;
 		} else
 			continue;
 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
