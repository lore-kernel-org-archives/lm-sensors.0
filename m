From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Apr 2013 09:45:02 +0000
Subject: [lm-sensors] [PATCH 4/5] pwmconfig: Properly deal with multiple fan control
Message-Id: <20130428114502.6ffb629c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When a given PWM output controls more than one fan,
fanactive_min is no longer a space-separated list of numbers, it will
also include items of the form "A+B". The tests in the rest of the
code do not expect that and choke with errors like:

/usr/sbin/pwmconfig: line 926: [: 538+799: integer expression expected
/usr/sbin/pwmconfig: line 952: [: 538+799: integer expression expected

As the only thing we really care about is whether any fan stops
completely when PWM is 0, we can simply record the minimum of the
lowest speed of all affected fans.
---
 prog/pwm/pwmconfig |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2013-04-09 14:27:17.121884123 +0200
+++ lm-sensors/prog/pwm/pwmconfig	2013-04-09 14:44:49.457542849 +0200
@@ -444,6 +444,7 @@ do
 
 	let pwmactivecount=0
 	let count=1
+	S_MIN 	for j in $GOODFAN
 	do
 		OS=`echo $SPEEDS | cut -d' ' -f$count`
@@ -462,7 +463,6 @@ do
 				let pwmactivecount=1
 				pwmactive="$i ${pwmactive}"
 				fanactive="$j ${fanactive}"
-				fanactive_min="$S ${fanactive_min}"
 
 				# Give all correlated fans time to return to full speed
 				sleep $DELAY
@@ -473,8 +473,14 @@ do
 				fi
 			else
 				fanactive="$j+${fanactive}"
-				fanactive_min="$S+${fanactive_min}"
 			fi
+
+			# Keep track of the slowest fan controlled by one PWM
+			if [ -z "$S_MIN" ] || [ $S -lt $S_MIN ]
+			then
+				S_MIN=$S
+			fi
+
 			S=`cat $j`
 			if [ $S -lt $threshold ]
 			then
@@ -507,8 +513,11 @@ do
 		if [ "$X" = "y" -o "$X" = "Y" ]
 		then
 			pwmactive="$i ${pwmactive}"
+			fanactive_min="0 $fanactive_min"
 		fi
 		echo
+	else
+		fanactive_min="$S_MIN $fanactive_min"
 	fi
 done
 

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
