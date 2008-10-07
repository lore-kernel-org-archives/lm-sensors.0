From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 07 Oct 2008 01:18:54 +0000
Subject: [lm-sensors] [PATCH 06/12] adt7470: Load automatically on
Message-Id: <20081007011854.12701.39465.stgit@elm3a70.beaverton.ibm.com>
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

 drivers/hwmon/adt7470.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/adt7470.c b/drivers/hwmon/adt7470.c
index 656bf3d..ef26014 100644
--- a/drivers/hwmon/adt7470.c
+++ b/drivers/hwmon/adt7470.c
@@ -1114,3 +1114,6 @@ MODULE_LICENSE("GPL");
 
 module_init(adt7470_init);
 module_exit(adt7470_exit);
+
+MODULE_ALIAS("dmi:bvnIBM:*:rn9228:*");
+MODULE_ALIAS("dmi:bvnIBM:*:rn9232:*");


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
