From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 06:08:01 +0000
Subject: [lm-sensors] [PATCH 5/5] ixgbe: Start temperature sensor attribute index with 1
Message-Id: <1385186881-7931-6-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Bruce Allan <bruce.w.allan@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>, Greg Rose <gregory.v.rose@intel.com>, Nithin Nayak Sujir <nsujir@broadcom.com>, Michael Chan <mchan@broadcom.com>, e1000-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

Per hwmon ABI, temperature sensor attribute index starts with 1, not 0.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
index 3081974..e74ae36 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_sysfs.c
@@ -118,22 +118,22 @@ static int ixgbe_add_hwmon_attr(struct ixgbe_adapter *adapter,
 	case IXGBE_HWMON_TYPE_LOC:
 		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_location;
 		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
-			 "temp%u_label", offset);
+			 "temp%u_label", offset + 1);
 		break;
 	case IXGBE_HWMON_TYPE_TEMP:
 		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_temp;
 		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
-			 "temp%u_input", offset);
+			 "temp%u_input", offset + 1);
 		break;
 	case IXGBE_HWMON_TYPE_CAUTION:
 		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_cautionthresh;
 		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
-			 "temp%u_max", offset);
+			 "temp%u_max", offset + 1);
 		break;
 	case IXGBE_HWMON_TYPE_MAX:
 		ixgbe_attr->dev_attr.show = ixgbe_hwmon_show_maxopthresh;
 		snprintf(ixgbe_attr->name, sizeof(ixgbe_attr->name),
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
