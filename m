From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Wed, 13 Aug 2008 22:40:15 +0000
Subject: [lm-sensors] [PATCH] ibmaem: Prevent infinite probing loop on x3650
Message-Id: <20080813224015.GA28450@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On older machines, probing for a nonexistent AEM interface returned an IPMI
error; when we saw this, we'd stop probing.  On the x3650 M2 and (presumably)
later, we are returned a value indicating success and a buffer full of garbage
or zeroes.  This causes the probe function to run in an infinite loop.  To fix
this, we add one last check--if the interface number we're looking for is
higher than the number of interfaces that AEM claims to have, stop probing.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/hwmon/ibmaem.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index c1ee7dd..0f70dc2 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -682,7 +682,8 @@ static int aem_find_aem2(struct aem_ipmi_data *data,
 		return -ETIMEDOUT;
 
 	if (data->rx_result || data->rx_msg_len != sizeof(*fi_resp) ||
-	    memcmp(&fi_resp->id, &system_x_id, sizeof(system_x_id)))
+	    memcmp(&fi_resp->id, &system_x_id, sizeof(system_x_id)) ||
+	    fi_resp->num_instances <= instance_num)
 		return -ENOENT;
 
 	return 0;

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
