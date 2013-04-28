From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Apr 2013 09:41:20 +0000
Subject: [lm-sensors] [PATCH 1/5] pwmconfig: Print the initial PWM values
Message-Id: <20130428114120.15fa2d9d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Print the initial PWM values before letting the user change them. This
should be useful to better understand what happens next, and for user
support in general.
---
 prog/pwm/pwmconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2010-08-22 18:18:00.000000000 +0200
+++ lm-sensors/prog/pwm/pwmconfig	2013-03-17 11:04:58.769048205 +0100
@@ -236,7 +236,8 @@ echo
 echo 'Found the following PWM controls:'
 for i in $PWM
 do
-	echo "   $i"
+	P=`cat $i`
+	echo "   $i           current value: $P"
 	if [ -w $i ]
 	then
 		# First check if PWM output is in automatic mode

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
