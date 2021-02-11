From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 11 Feb 2021 14:37:03 +0000
Subject: [PATCH] pwmconfig: Further raise the fan threshold
Message-Id: <20210211153703.501b0a3b@endymion>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Modern 4-pin fans can have a minimum speed (PWM=0) which is still
relatively high. I've seen 4500 RPM fans lower their speed to only
3500 RPM, which is 77% of the maximum speed, above our current
detection threshold (3/4 or 75%). Increase the threshold to 5/6
(roughly 83%) to make sure such fans are handled properly.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 prog/pwm/pwmconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lm-sensors.orig/prog/pwm/pwmconfig	2021-02-11 11:31:40.636126815 +0100
+++ lm-sensors/prog/pwm/pwmconfig	2021-02-11 15:30:12.831007617 +0100
@@ -455,7 +455,7 @@ do
 		OS=$(echo $SPEEDS | cut -d' ' -f$count)
 		S=$(echo $CURRENT_SPEEDS | cut -d' ' -f$count)
 		echo "  $j ... speed was $OS now $S"
-		let threshold=3*$OS/4
+		let threshold=5*$OS/6
 		if [ $S -lt $threshold ]
 		then
 			echo "    It appears that fan $j"


-- 
Jean Delvare
SUSE L3 Support
