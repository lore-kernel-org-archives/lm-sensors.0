From: Maximilian Seesslen <mes@seesslen.net>
Date: Fri, 12 Jul 2013 17:12:51 +0000
Subject: [lm-sensors] [PATCH] fix fancontrol to survive a system suspend
Message-Id: <201307121912.51382.mes@seesslen.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Boundary-00=_TkD4RQJEOFN7dlf"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--Boundary-00=_TkD4RQJEOFN7dlf
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

find attached a patch that fixes fancontrol to survive a system suspend. 

If the daemon can not set the pwm values but it did it already in the past 
successfully, it tries to reenable the pwm output instead of quitting.


Regards,
   Max


--
Maximilian Seesslen

--Boundary-00=_TkD4RQJEOFN7dlf
Content-Type: text/x-patch;
  charset="UTF-8";
  name="fix-fancontrol-to-survive-a-system-suspend-hibernate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="fix-fancontrol-to-survive-a-system-suspend-hibernate.diff"

Index: prog/pwm/fancontrol
===================================================================
--- prog/pwm/fancontrol	(Revision 6189)
+++ prog/pwm/fancontrol	(Arbeitskopie)
@@ -42,6 +42,7 @@
 
 #DEBUG=1
 MAX=255
+DID_FIRSTRUN=0
 
 function LoadConfig
 {
@@ -490,7 +491,12 @@
 		if [ $? -ne 0 ]
 		then
 			echo "Error writing PWM value to $DIR/$pwmo" >&2
-			restorefans 1
+			[ "$DID_FIRSTRUN" == "0" ] && restorefans 1
+			# Ignoring write error. System probably was syspended and has to reanable pwm.
+			echo "Ignoring, i try reanabling PWM."
+			pwmenable $pwmo
+			# Write values again to keep failure short
+			echo $pwmval > $pwmo # write new value to pwm output
 		fi
 		if [ "$DEBUG" != "" ]
 		then
@@ -498,6 +504,8 @@
 		fi
 		let fcvcount=$fcvcount+1
 	done
+	
+	DID_FIRSTRUN=1
 }
 
 echo 'Enabling PWM on fans...'

--Boundary-00=_TkD4RQJEOFN7dlf
Content-Type: text/x-patch;
  charset="UTF-8";
  name="0001-fix-fancontrol-to-survive-a-system-suspend-hibernate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-fix-fancontrol-to-survive-a-system-suspend-hibernate.patch"

=46rom 46940390c8f9fcc4325710867c95b2e28aebaf81 Mon Sep 17 00:00:00 2001
=46rom: Maximilian Seesslen <mes@seesslen.net>
Date: Fri, 12 Jul 2013 18:59:49 +0200
Subject: [PATCH] fix fancontrol to survive a system suspend/hibernate

=2D--
 prog/pwm/fancontrol |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/prog/pwm/fancontrol b/prog/pwm/fancontrol
index 2771139..3e57901 100755
=2D-- a/prog/pwm/fancontrol
+++ b/prog/pwm/fancontrol
@@ -42,6 +42,7 @@ PIDFILE=3D"/var/run/fancontrol.pid"
=20
 #DEBUG=3D1
 MAX=3D255
+DID_FIRSTRUN=3D0
=20
 function LoadConfig
 {
@@ -490,7 +491,12 @@ function UpdateFanSpeeds
 		if [ $? -ne 0 ]
 		then
 			echo "Error writing PWM value to $DIR/$pwmo" >&2
=2D			restorefans 1
+			[ "$DID_FIRSTRUN" =3D=3D "0" ] && restorefans 1
+			# Ignoring write error. System probably was syspended and has to reanab=
le pwm.
+			echo "Ignoring, i try reanabling PWM."
+			pwmenable $pwmo
+			# Write values again to keep failure short
+			echo $pwmval > $pwmo # write new value to pwm output
 		fi
 		if [ "$DEBUG" !=3D "" ]
 		then
@@ -498,6 +504,8 @@ function UpdateFanSpeeds
 		fi
 		let fcvcount=3D$fcvcount+1
 	done
+=09
+	DID_FIRSTRUN=3D1
 }
=20
 echo 'Enabling PWM on fans...'
=2D-=20
1.7.10.4


--Boundary-00=_TkD4RQJEOFN7dlf
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--Boundary-00=_TkD4RQJEOFN7dlf--
