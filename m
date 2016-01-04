From: David Binderman <dcb314@hotmail.com>
Date: Mon, 04 Jan 2016 17:56:47 +0000
Subject: [lm-sensors] linux-4.4-rc8/drivers/hwmon/lm93.c:398: possible int/long mixup ?
Message-Id: <DUB128-W1671C249B3641DADF3A70A9CF20@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello there,

[linux-4.4-rc8/drivers/hwmon/lm93.c:398]: (style) int result is assigned to=
 long variable. If the variable is long to avoid loss of information, then =
you have loss of information.

Source code is

=A0=A0=A0 const long uv_vid =3D vid * 1000;

Suggest new code

=A0=A0=A0 const long uv_vid =3D vid * 1000L;

to make sure that integer overflow will not occur.

Regards

David Binderman

 		 	   		 =20
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
