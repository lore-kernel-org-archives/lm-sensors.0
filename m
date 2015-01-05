From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Date: Mon, 05 Jan 2015 08:57:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: nct7802: Constify struct regmap_config
Message-Id: <1420448275-8154-1-git-send-email-k.kozlowski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

The regmap_config struct may be const because it is not modified by the
driver and regmap_init() accepts pointer to const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/hwmon/nct7802.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7802.c b/drivers/hwmon/nct7802.c
index ec5678289e4a..55765790907b 100644
--- a/drivers/hwmon/nct7802.c
+++ b/drivers/hwmon/nct7802.c
@@ -779,7 +779,7 @@ static bool nct7802_regmap_is_volatile(struct device *dev, unsigned int reg)
 	return reg != REG_BANK && reg <= 0x20;
 }
 
-static struct regmap_config nct7802_regmap_config = {
+static const struct regmap_config nct7802_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_RBTREE,
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
