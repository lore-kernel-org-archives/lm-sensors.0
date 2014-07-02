From: Axel Lin <axel.lin@ingics.com>
Date: Wed, 02 Jul 2014 00:42:18 +0000
Subject: [lm-sensors] [PATCH] hwmon: Make regmap configs const
Message-Id: <1404261738.14234.1.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/emc1403.c | 2 +-
 drivers/hwmon/ltc2945.c | 2 +-
 drivers/hwmon/ltc4222.c | 2 +-
 drivers/hwmon/ltc4260.c | 2 +-
 drivers/hwmon/tmp103.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index a37b220..1ea7ca5 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -416,7 +416,7 @@ static bool emc1403_regmap_is_volatile(struct device *dev, unsigned int reg)
 	}
 }
 
-static struct regmap_config emc1403_regmap_config = {
+static const struct regmap_config emc1403_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 3701b32..1b92e4f 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -469,7 +469,7 @@ static struct attribute *ltc2945_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ltc2945);
 
-static struct regmap_config ltc2945_regmap_config = {
+static const struct regmap_config ltc2945_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = LTC2945_MIN_ADIN_THRES_L,
diff --git a/drivers/hwmon/ltc4222.c b/drivers/hwmon/ltc4222.c
index 07c2565..88f7472 100644
--- a/drivers/hwmon/ltc4222.c
+++ b/drivers/hwmon/ltc4222.c
@@ -186,7 +186,7 @@ static struct attribute *ltc4222_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ltc4222);
 
-static struct regmap_config ltc4222_regmap_config = {
+static const struct regmap_config ltc4222_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = LTC4222_ADC_CONTROL,
diff --git a/drivers/hwmon/ltc4260.c b/drivers/hwmon/ltc4260.c
index 453a250..afb09574 100644
--- a/drivers/hwmon/ltc4260.c
+++ b/drivers/hwmon/ltc4260.c
@@ -150,7 +150,7 @@ static struct attribute *ltc4260_attrs[] = {
 };
 ATTRIBUTE_GROUPS(ltc4260);
 
-static struct regmap_config ltc4260_regmap_config = {
+static const struct regmap_config ltc4260_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = LTC4260_ADIN,
diff --git a/drivers/hwmon/tmp103.c b/drivers/hwmon/tmp103.c
index e69dbca..f4770b4 100644
--- a/drivers/hwmon/tmp103.c
+++ b/drivers/hwmon/tmp103.c
@@ -116,7 +116,7 @@ static bool tmp103_regmap_is_volatile(struct device *dev, unsigned int reg)
 	return reg = TMP103_TEMP_REG;
 }
 
-static struct regmap_config tmp103_regmap_config = {
+static const struct regmap_config tmp103_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = TMP103_THIGH_REG,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
