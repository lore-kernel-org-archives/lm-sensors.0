From: Jingoo Han <jg1.han@samsung.com>
Date: Tue, 29 Apr 2014 08:07:58 +0000
Subject: [lm-sensors] [PATCH 2/8] hwmon: (ibmpex) remove unnecessary OOM messages
Message-Id: <001b01cf6382$225ca930$6715fb90$%han@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/hwmon/ibmpex.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/ibmpex.c b/drivers/hwmon/ibmpex.c
index 20ab0fb..030e7ff 100644
--- a/drivers/hwmon/ibmpex.c
+++ b/drivers/hwmon/ibmpex.c
@@ -463,10 +463,8 @@ static void ibmpex_register_bmc(int iface, struct device *dev)
 	int err;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(dev, "Insufficient memory for BMC interface.\n");
+	if (!data)
 		return;
-	}
 
 	data->address.addr_type = IPMI_SYSTEM_INTERFACE_ADDR_TYPE;
 	data->address.channel = IPMI_BMC_CHANNEL;
-- 
1.7.10.4



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
