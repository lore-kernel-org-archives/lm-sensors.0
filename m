From: Jiri Slaby <jirislaby@gmail.com>
Date: Fri, 19 Jun 2009 21:26:35 +0000
Subject: [lm-sensors] [PATCH 1/1] HWMON: max6650, fix lock imbalance
Message-Id: <1245446795-1901-1-git-send-email-jirislaby@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: hjk@linutronix.de
Cc: lm-sensors@lm-sensors.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>

Add omitted update_lock to one switch/case in set_div.

Signed-off-by: Jiri Slaby <jirislaby@gmail.com>
---
 drivers/hwmon/max6650.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/max6650.c b/drivers/hwmon/max6650.c
index 86142a8..58f66be 100644
--- a/drivers/hwmon/max6650.c
+++ b/drivers/hwmon/max6650.c
@@ -418,6 +418,7 @@ static ssize_t set_div(struct device *dev, struct device_attribute *devattr,
 		data->count = 3;
 		break;
 	default:
+		mutex_unlock(&data->update_lock);
 		dev_err(&client->dev,
 			"illegal value for fan divider (%d)\n", div);
 		return -EINVAL;
-- 
1.6.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
