From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:19:14 +0000
Subject: [lm-sensors] [PATCH 10/12] ibmaem: Automatically load on IBM
Message-Id: <20081007011914.12701.7023.stgit@elm3a70.beaverton.ibm.com>
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

 drivers/hwmon/ibmaem.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 0f70dc2..980145a 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -1118,3 +1118,10 @@ MODULE_LICENSE("GPL");
 
 module_init(aem_init);
 module_exit(aem_exit);
+
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3650*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3550*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3655*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3755*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBMSystemx3350*");
+MODULE_ALIAS("dmi:bvnIBM:*:pnIBM3850M2/x3950M2*");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
