From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:19:09 +0000
Subject: [lm-sensors] [PATCH 09/12] ibmpex: Automatically load on IBM
Message-Id: <20081007011909.12701.96969.stgit@elm3a70.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081007011824.12701.39532.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-scsi@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>


Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmpex.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 4e9b19c..6e3a2c4 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -608,3 +608,9 @@ MODULE_LICENSE("GPL");
 
 module_init(ibmpex_init);
 module_exit(ibmpex_exit);
+
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3650*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3550*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3655*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3755*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3350*");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
