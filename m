From: Chusslove Illich <caslav.ilic@gmx.net>
Date: Wed, 21 Mar 2012 10:54:23 +0000
Subject: [lm-sensors] fancontrol: max of multiple temp sensors for single PWM control
Message-Id: <201203211154.23477.caslav.ilic@gmx.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1091735508212712250=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============1091735508212712250==
Content-Type: multipart/signed;
  boundary="nextPart6171600.HzaNW4UWc6";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart6171600.HzaNW4UWc6
Content-Type: multipart/mixed;
  boundary="Boundary-01=_fNbaP+ayhK70rS7"
Content-Transfer-Encoding: 7bit


--Boundary-01=_fNbaP+ayhK70rS7
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A while back, there was this post

http://lists.lm-sensors.org/pipermail/lm-sensors/2010-July/029109.html

which sumed up the issue (for me, the alternating-fan sound pattern is
annoying). I attach a patch to make this possible, by giving a comma-
separated list of temperature sensors in FCTEMPS.

I've tested it by forcing the affinity of a high-load process to different
cores, while monitoring the /sys/class/hwmon/hwmonN/device/pwmM contents to
make sure it does not change.

(Not subscribed, please CC.)

=2D-=20
Chusslove Illich (=D0=A7=D0=B0=D1=81=D0=BB=D0=B0=D0=B2 =D0=98=D0=BB=D0=B8=
=D1=9B)

--Boundary-01=_fNbaP+ayhK70rS7
Content-Type: text/x-patch;
  charset="utf-8";
  name="fancontrol-multi-temp-pwm-map-01.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fancontrol-multi-temp-pwm-map-01.diff"

Index: doc/fancontrol.txt
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- doc/fancontrol.txt	(revision 6037)
+++ doc/fancontrol.txt	(working copy)
@@ -37,6 +37,10 @@
 	Maps pwm outputs to temperature sensors so fancontrol knows which
 	temperature sensors should be used for calculation of new values for
 	the corresponding pwm outputs.
+	Several temperature sensors may be mapped to single pwm output
+	as a comma-separated list, in which case the maximum of all readings
+	is taken as the referent temperature. This is useful for a CPU fan
+	on a multi-core CPU with separate temperature sensors per core.
=20
 FCFANS
 	FCFANS records the association between a pwm and a fan.
Index: prog/pwm/fancontrol
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- prog/pwm/fancontrol	(revision 6037)
+++ prog/pwm/fancontrol	(working copy)
@@ -224,12 +224,14 @@
 	let fcvcount=3D0
 	while (( $fcvcount < ${#AFCTEMP[@]} )) # go through all temp inputs
 	do
=2D		tsen=3D${AFCTEMP[$fcvcount]}
=2D		if [ ! -r $tsen ]
=2D		then
=2D			echo "Error: file $tsen doesn't exist" >&2
=2D			outdated=3D1
=2D		fi
+		for tsen in $(echo ${AFCTEMP[$fcvcount]} | tr ',' ' ')
+		do
+			if [ ! -r $tsen ]
+			then
+				echo "Error: file $tsen doesn't exist" >&2
+				outdated=3D1
+			fi
+		done
 		let fcvcount=3D$fcvcount+1
 	done
=20
@@ -391,12 +393,20 @@
 		minpwm=3D${AFCMINPWM[$fcvcount]}
 		maxpwm=3D${AFCMAXPWM[$fcvcount]}
=20
=2D		read tval < ${tsens}
=2D		if [ $? -ne 0 ]
=2D		then
=2D			echo "Error reading temperature from $DIR/$tsens"
=2D			restorefans 1
=2D		fi
+		tval=3D0
+		for tsen in $(echo ${tsens} | tr ',' ' ')
+		do
+			read tval1 < ${tsen}
+			if [ $? -ne 0 ]
+			then
+				echo "Error reading temperature from $DIR/$tsen"
+				restorefans 1
+			fi
+			if [ $tval -lt $tval1 ]
+			then
+				tval=3D$tval1
+			fi
+		done
=20
 		read pwmpval < ${pwmo}
 		if [ $? -ne 0 ]

--Boundary-01=_fNbaP+ayhK70rS7--

--nextPart6171600.HzaNW4UWc6
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAk9ps18ACgkQMSGXgigGr3FXKACghn2o6lBoShAdWWIObrddiTRH
i/cAoLe6a+QIa7zepmFqBEIkHrqFOuJW
=9+D/
-----END PGP SIGNATURE-----

--nextPart6171600.HzaNW4UWc6--


--===============1091735508212712250==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1091735508212712250==--
