From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Apr 2013 09:42:17 +0000
Subject: [lm-sensors] [PATCH 2/5] pwmconfig: Raise the detection threshold
Message-Id: <20130428114217.0f1a2903@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Detection threshold of 2/3 of the maximum speed is too low, some fans
will slow down to about that speed so controlled fans may be missed.
Use 3/4 as the threshold to avoid these false negatives.
---
 prog/pwm/pwmconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2013-03-27 15:40:11.765902023 +0100
+++ lm-sensors/prog/pwm/pwmconfig	2013-03-27 16:11:52.899055263 +0100
@@ -449,7 +449,7 @@ do
 		OS=`echo $SPEEDS | cut -d' ' -f$count`
 		S=`echo $CURRENT_SPEEDS | cut -d' ' -f$count`
 		echo "  $j ... speed was $OS now $S"
-		let threshold=2*$OS/3
+		let threshold=3*$OS/4
 		if [ $S -lt $threshold ]
 		then
 			echo "    It appears that fan $j"

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
