From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:40:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: fscher read control bugfix
Message-Id: <1185846001484-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Hans de Goede <j.w.r.degoede@hhs.nl>

Here is a small fscher bugfix for 2.6.23 merging, lifted from my other fscher
work, as requested by Jean. The current driver has a control sysfs attribute,
which shows the contents of the control register, but the underlying
global_control value in the data structure currently never gets filled with
the actual contents of this register.

Signed-off-by: Hans de Goede <j.w.r.degoede@hhs.nl>
Acked-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/fscher.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/fscher.c b/drivers/hwmon/fscher.c
index f3aa188..b34b546 100644
--- a/drivers/hwmon/fscher.c
+++ b/drivers/hwmon/fscher.c
@@ -441,6 +441,8 @@ static struct fscher_data *fscher_update_device(struct device *dev)
 		data->watchdog[2] = fscher_read_value(client, FSCHER_REG_WDOG_CONTROL);
 
 		data->global_event = fscher_read_value(client, FSCHER_REG_EVENT_STATE);
+		data->global_control = fscher_read_value(client,
+							FSCHER_REG_CONTROL);
 
 		data->last_updated = jiffies;
 		data->valid = 1;                 
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
