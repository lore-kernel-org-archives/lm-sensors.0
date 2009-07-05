From: =?ISO-8859-2?Q?H=E1morszky_Bal=E1zs?= <balihb@gmail.com>
Date: Sun, 05 Jul 2009 01:09:51 +0000
Subject: [lm-sensors] MINSTART has no effect in fancontrol
Message-Id: <4A4FFD5F.6060508@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi!

In fancontrol MINSTART has no effect (it has, but only for an INTERVAL=20
period of time).
The line:
pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minso})/(${maxt}-${mint})+${minso}"
should be:
pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minsa})/(${maxt}-${mint})+${minsa}"
if I understand the configuration options of fancontrol right. At the=20
current state, pwmval can be lower than MINSTART (so on some=20
temperatures, greater than MINTEMP, the fan won't start).

Regards,
Bal=E1zs

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
