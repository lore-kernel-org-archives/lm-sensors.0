From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Apr 2013 09:42:57 +0000
Subject: [lm-sensors] [PATCH 3/5] pwmconfig: Drop a stray comment
Message-Id: <20130428114257.7eece497@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fancontrol supports multiple controlled fans for quite some time now.
---
 prog/pwm/pwmconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2013-04-03 10:33:18.906884864 +0200
+++ lm-sensors/prog/pwm/pwmconfig	2013-04-03 10:39:27.883195930 +0200
@@ -472,7 +472,7 @@ do
 					exit 1
 				fi
 			else
-				fanactive="$j+${fanactive}" #not supported yet by fancontrol
+				fanactive="$j+${fanactive}"
 				fanactive_min="$S+${fanactive_min}"
 			fi
 			S=`cat $j`

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
