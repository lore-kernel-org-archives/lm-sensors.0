From: =?iso-8859-1?Q?Bj=F6rn_Gerhart?= <oss@extracloud.de>
Date: Fri, 23 Mar 2012 23:24:58 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <1149E1C9-FD96-44BF-BB90-A10361356DA4@extracloud.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Jean,


Am 23.03.2012 um 22:02 schrieb Jean Delvare:

> On Tue, 13 Mar 2012 19:43:15 +0100, Bjoern Gerhart wrote:
>> 2012/3/8 Guenter Roeck <linux@roeck-us.net>:
>>> Assume all three are compatible and have the same functionality.
>>>=20
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> Tested-by: Bjoern Gerhart <oss@extracloud.de>
>=20
> Care to share the output of "sensors" with us?
>=20
Sure. To be more precise, I tested with an IT8783 chip configured and wired=
 by the hardware team at the company I'm working for on a proprietary mainb=
oard. With the sensors.conf created therefore, the sensors output looks lik=
e this:

[root@localhost ~]# LANG=3DC sensors
it8783-isa-0a10
Adapter: ISA adapter
CPU Core:    +1.15 V  (min =3D  +0.70 V, max =3D  +1.70 V)
+1.50V:      +1.50 V  (min =3D  +1.10 V, max =3D  +1.90 V)
+3.30V:      +3.38 V  (min =3D  +2.70 V, max =3D  +4.00 V)
+12.0V:     +12.16 V  (min =3D +10.69 V, max =3D +13.70 V)
-12.0V:     -11.95 V  (min =3D -13.68 V, max =3D -10.30 V)
+1.10V:      +1.12 V  (min =3D  +0.90 V, max =3D  +1.22 V)
VBat:        +3.09 V
Fan1:       1662 RPM  (min =3D  300 RPM)
PSU:        1245 RPM  (min =3D  500 RPM)
Board T.:    +30.0 C  (low  =3D  +0.0 C, high =3D +55.0 C)  sensor =3D ther=
mal diode
CPU T.:      +47.0 C  (low  =3D  +0.0 C, high =3D +63.0 C)  sensor =3D ther=
mal diode

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +40.0 C  (high =3D +86.0 C, crit =3D +100.0 C)
Core 1:      +43.0 C  (high =3D +86.0 C, crit =3D +100.0 C)


These are about the same values as the "Hardware Monitor" section at the BI=
OS setup shows also. So all values look reasonable.


In general, for future Tested-bys: does it make sense to append a kind of t=
est report (like the above one) directly after the Tested-by statement, or =
should it be located in a separate mail?

Bj=F6rn


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
