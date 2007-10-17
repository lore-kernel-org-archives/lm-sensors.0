From: Adrian Bunk <bunk@kernel.org>
Date: Wed, 17 Oct 2007 19:29:02 +0000
Subject: [lm-sensors] [2.6 patch] hwmon/ibmpex.c: fix NULL dereference
Message-Id: <20071017192902.GB3778@stusta.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Don't dereference "data" when we know for sure it's NULL.

Spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
66bec2ef5c6d55fc30ef6ac5bb97fdfcfaf394f2 
diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index c462824..e14ce3d 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -457,7 +457,7 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		printk(KERN_ERR DRVNAME ": Insufficient memory for BMC "
-		       "interface %d.\n", data->interface);
+		       "interface.\n");
 		return;
 	}
 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
