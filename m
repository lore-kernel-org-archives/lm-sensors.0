From: magnus.f@telia.com (=?iso-8859-1?Q?Magnus=20Forsstr=F6m?=)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <200308121447.h7CEloK21314@d1o403.telia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!
I only downloaded the lm83.c file and recompiled it. How do I see/test
the status register? I was expecting something from the sensors output.

The sensors output was:
Adapter: SMBus PIIX4 adapter at 0580
Algorithm: Non-I2C SMBus adapter
temp1:       +36=B0C  (limit =3D +100=B0C)                     =20
temp2:       +39=B0C  (limit =3D +100=B0C)                     =20
temp3:       +50=B0C  (limit =3D +100=B0C)                     =20
temp4:       +42=B0C  (limit =3D +100=B0C)       =20

In the proc filesystem Ive got:
# ls /proc/sys/dev/sensors/lm83-i2c-0-19/
alarms  tcrit   temp1   temp2   temp3   temp4  =20

# cat /proc/sys/dev/sensors/lm83-i2c-0-19/tcrit
120
# cat /proc/sys/dev/sensors/lm83-i2c-0-19/alarms=20
0

Regards
Magnus Forsstr=F6m
