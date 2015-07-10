From: Axel Lin <axel.lin@ingics.com>
Date: Fri, 10 Jul 2015 04:59:13 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: pmbus: Explicitly set regulator type for pmbus_regulator_ops
Message-Id: <1436504353.17707.1.camel@ingics.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The pmbus_regulator_ops is for voltage regulators, so explicitly set
regulator type for better readability.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/pmbus/pmbus.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index 89a23ff..21f8b2f 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -390,6 +390,7 @@ extern struct regulator_ops pmbus_regulator_ops;
 		.of_match = of_match_ptr(_name # _id),		\
 		.regulators_node = of_match_ptr("regulators"),	\
 		.ops = &pmbus_regulator_ops,			\
+		.type = REGULATOR_VOLTAGE,			\
 		.owner = THIS_MODULE,				\
 	}
 
-- 
2.1.0




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
