From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 28 Oct 2010 13:20:23 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc4261) Add missing newline in debug
Message-Id: <1288272023-11588-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101028151632.081a0fdf@endymion.delvare>
In-Reply-To: <20101028151632.081a0fdf@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/ltc4261.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 2676261..15f137b 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -82,7 +82,7 @@ static struct ltc4261_data *ltc4261_update_device(struct device *dev)
 			val = i2c_smbus_read_byte_data(client, i);
 			if (unlikely(val < 0)) {
 				dev_dbg(dev,
-					"Failed to read ADC value: error %d",
+					"Failed to read ADC value: error %d\n",
 					val);
 				ret = ERR_PTR(val);
 				goto abort;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
