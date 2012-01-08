From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 16:23:25 +0000
Subject: [lm-sensors] [PATCH 02/17] drivers/hwmon/ibmaem.c: fix checkpatch
Message-Id: <1326039820-11147-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/ibmaem.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/ibmaem.c b/drivers/hwmon/ibmaem.c
index 6a967d7..24b1524 100644
--- a/drivers/hwmon/ibmaem.c
+++ b/drivers/hwmon/ibmaem.c
@@ -1045,7 +1045,7 @@ static struct aem_ro_sensor_template aem2_ro_sensors[] = {
 {"power6_average",	  aem2_show_pcap_value,	POWER_CAP_MIN_WARNING},
 {"power7_average",	  aem2_show_pcap_value,	POWER_CAP_MIN},
 
-{"power3_average", 	  aem2_show_pcap_value,	POWER_AUX},
+{"power3_average",	  aem2_show_pcap_value,	POWER_AUX},
 {"power_cap",		  aem2_show_pcap_value,	POWER_CAP},
 {NULL,                    NULL,                 0},
 };
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
