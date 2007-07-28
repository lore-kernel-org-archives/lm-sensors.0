From: cilly <cilly@cilly.mine.nu>
Date: Sat, 28 Jul 2007 00:05:04 +0000
Subject: Re: [lm-sensors] VT1211: wrong vid, vcore
Message-Id: <F916B6C7-106F-43E9-BF38-B9F9234DE531@cilly.mine.nu>
List-Id: <lm-sensors.vger.kernel.org>
References: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
In-Reply-To: <08D6463A-3693-42BE-B8E5-6D32758A3C03@cilly.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Jul 28, 2007, at 1:23 AM, Juerg Haefliger wrote:

> Hi cilly,
>
> I'm in the process of adding PMW fan control to my M10000. Hopefully I
> can reproduce your findings then and be able to figure out what's
> going on. Give my a couple of days...
>
> ...juerg

Hi Juerg,

thx for helping. Take the time you need. Next week, I am out on a =20
trip to Black Forrest and won't be able to access my machine =20
physically, i.e. adding a fan. It runs - with the heatpipes - totally =20
without fans as you can see:

$ sensors
vt1211-isa-6000
Adapter: ISA adapter
+3.3V:     +3.30 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+2.5V:     +2.46 V  (min =3D  +2.37 V, max =3D  +2.63 V)
VCore:     +1.40 V  (min =3D  +1.35 V, max =3D  +1.44 V)
+5V:       +5.05 V  (min =3D  +4.51 V, max =3D  +5.51 V)
+12V:     +12.09 V  (min =3D +10.77 V, max =3D +13.22 V)
+3.3V:     +3.28 V  (min =3D  +3.13 V, max =3D  +3.46 V)
Case Fan:    0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Fan:     0 RPM  (min =3D    0 RPM, div =3D 2)
CPU Temp:  +47.5=B0C  (high =3D   +85=B0C, hyst =3D   +79=B0C)
Int Temp:  +62.0=B0C  (high =3D   +65=B0C, hyst =3D   +60=B0C)
vid:      +1.250 V  (VRM Version 8.5)

While running burnMMX (cpuburn) for about 3-4 hours, the cpu reaches =20
a top of 65 =B0C while the internal temp goes up to max. 67-68 =B0C.

Regards,

c.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
