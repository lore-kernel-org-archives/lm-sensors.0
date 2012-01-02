From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Mon, 02 Jan 2012 11:03:20 +0000
Subject: [lm-sensors] [PATCH 1/4] drivers/hwmon/ltc4261: set data->valid to
Message-Id: <1325502203-10525-1-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if there is an error it is better to set data->valid to 0
so the next call to ltc4261_update_device will always be
executed

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
patch is against the hwmon staging tree
git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
as retrieved on jan 2, 2012

 drivers/hwmon/ltc4261.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/ltc4261.c b/drivers/hwmon/ltc4261.c
index 4b50601..ce52355 100644
--- a/drivers/hwmon/ltc4261.c
+++ b/drivers/hwmon/ltc4261.c
@@ -85,6 +85,7 @@ static struct ltc4261_data *ltc4261_update_device(struct device *dev)
 					"Failed to read ADC value: error %d\n",
 					val);
 				ret = ERR_PTR(val);
+				data->valid = 0;
 				goto abort;
 			}
 			data->regs[i] = val;
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
