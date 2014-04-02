From: Lubos Lunak <l.lunak@centrum.cz>
Date: Wed, 02 Apr 2014 10:53:49 +0000
Subject: [lm-sensors] [PATCH] fancontrol aborts after suspend/resume
Message-Id: <201404021253.49647.l.lunak@centrum.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_9w+OTFnnafFE9ws"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_9w+OTFnnafFE9ws
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


 Hello,

 if system running fancontrol is suspended and resumed, fancontrol will abort, 
as writing the pwm value will fail because of pwm control being set to 
automatic control after the resume (google for 'fancontrol suspend' for 
various discussions about this). The attached patch fixes the problem.

 I'm not subscribed, so please CC me on any possible replies.

-- 
 Lubos Lunak

--Boundary-00=_9w+OTFnnafFE9ws
Content-Type: text/x-diff;
  charset="iso 8859-15";
  name="l-resume.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="l-resume.patch"

--- prog/pwm/fancontrol.sav	2014-04-01 20:06:29.000000000 +0200
+++ prog/pwm/fancontrol	2014-04-02 12:40:52.376746067 +0200
@@ -504,8 +504,14 @@ function UpdateFanSpeeds
 		echo $pwmval > $pwmo # write new value to pwm output
 		if [ $? -ne 0 ]
 		then
-			echo "Error writing PWM value to $DIR/$pwmo" >&2
-			restorefans 1
+			# Try enabling the fan again (may be reset e.g. after a suspend/resume).
+			pwmenable $pwmo
+			echo $pwmval > $pwmo
+			if [ $? -ne 0 ]
+			then
+				echo "Error writing PWM value to $DIR/$pwmo" >&2
+				restorefans 1
+			fi
 		fi
 		if [ "$DEBUG" != "" ]
 		then

--Boundary-00=_9w+OTFnnafFE9ws
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_9w+OTFnnafFE9ws--
