From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 06:08:00 +0000
Subject: [lm-sensors] [PATCH 4/5] igb: Start temperature sensor attribute index with 1
Message-Id: <1385186881-7931-5-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Nithin Nayak Sujir <nsujir@broadcom.com>, e1000-devel@lists.sourceforge.net, Bruce Allan <bruce.w.allan@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, lm-sensors@lm-sensors.org, Michael Chan <mchan@broadcom.com>, "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>

Per hwmon ABI, temperature sensor attribute index starts with 1, not 0.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/ethernet/intel/igb/igb_hwmon.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_hwmon.c b/drivers/net/ethernet/intel/igb/igb_hwmon.c
index 2e7ef2d..e0af5bc 100644
--- a/drivers/net/ethernet/intel/igb/igb_hwmon.c
+++ b/drivers/net/ethernet/intel/igb/igb_hwmon.c
@@ -124,22 +124,22 @@ static int igb_add_hwmon_attr(struct igb_adapter *adapter,
 	case IGB_HWMON_TYPE_LOC:
 		igb_attr->dev_attr.show = igb_hwmon_show_location;
 		snprintf(igb_attr->name, sizeof(igb_attr->name),
-			 "temp%u_label", offset);
+			 "temp%u_label", offset + 1);
 		break;
 	case IGB_HWMON_TYPE_TEMP:
 		igb_attr->dev_attr.show = igb_hwmon_show_temp;
 		snprintf(igb_attr->name, sizeof(igb_attr->name),
-			 "temp%u_input", offset);
+			 "temp%u_input", offset + 1);
 		break;
 	case IGB_HWMON_TYPE_CAUTION:
 		igb_attr->dev_attr.show = igb_hwmon_show_cautionthresh;
 		snprintf(igb_attr->name, sizeof(igb_attr->name),
-			 "temp%u_max", offset);
+			 "temp%u_max", offset + 1);
 		break;
 	case IGB_HWMON_TYPE_MAX:
 		igb_attr->dev_attr.show = igb_hwmon_show_maxopthresh;
 		snprintf(igb_attr->name, sizeof(igb_attr->name),
-			 "temp%u_crit", offset);
+			 "temp%u_crit", offset + 1);
 		break;
 	default:
 		rc = -EPERM;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
