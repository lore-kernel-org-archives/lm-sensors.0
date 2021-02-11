From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 11 Feb 2021 12:10:12 +0000
Subject: [PATCH] pwmconfig: Deal gracefully with unreadable fan inputs
Message-Id: <20210211131012.2633e64a@endymion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If a hwmon driver exposes an unreadable fan input, let the user know
and skip that input. Otherwise we hit syntax errors later on.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 prog/pwm/pwmconfig |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2020-05-07 14:29:34.731733274 +0200
+++ lm-sensors/prog/pwm/pwmconfig	2021-02-11 11:31:40.636126815 +0100
@@ -283,8 +283,11 @@ sleep $DELAY
 echo 'Found the following fan sensors:'
 for i in $FAN
 do
-	S=$(cat $i)
-	if [ "$S" = "0" -o "$S" = "-1" ]
+	S=$(cat $i 2> /dev/null)
+	if [ $? -ne 0 ]
+	then
+		echo "   $i     current speed: can't read ... skipping!"
+	elif [ "$S" = "0" -o "$S" = "-1" ]
 	then
 		echo "   $i     current speed: 0 ... skipping!"
 	else


-- 
Jean Delvare
SUSE L3 Support
