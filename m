From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2007 10:00:39 +0000
Subject: [lm-sensors] [PATCH] hwmon/w83627hf: Be quiet when no chip is found
Message-Id: <20070516120039.2d63152b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627hf.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- linux-2.6.22-rc1.orig/drivers/hwmon/w83627hf.c	2007-05-16 08:55:57.000000000 +0200
+++ linux-2.6.22-rc1/drivers/hwmon/w83627hf.c	2007-05-16 11:56:28.000000000 +0200
@@ -965,8 +965,10 @@ static int __init w83627hf_find(int sioa
 	case W687THF_DEVID:
 		sio_data->type = w83687thf;
 		break;
+	case 0xff:	/* No device at all */
+		goto exit;
 	default:
-		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%x)\n", val);
+		pr_debug(DRVNAME ": Unsupported chip (DEVID=0x%02x)\n", val);
 		goto exit;
 	}
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
