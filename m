From: magnus.f@telia.com (=?iso-8859-1?Q?Magnus=20Forsstr=F6m?=)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: New LM83 driver
Message-Id: <200308121845.h7CIjZe12371@d1o265.telia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809231304.74f73999.khali@linux-fr.org>
In-Reply-To: <20030809231304.74f73999.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello!
Thanks Jean I grabbed your CVS snapshot and compiled it. Worked fine!
# prog/sensors/sensors -A lm83-i2c-0-19
lm83-i2c-0-19
temp1:       +36=B0C  (limit =3D +100=B0C, critical =3D +120=B0C)  =20
temp2:       +35=B0C  (limit =3D +100=B0C, critical =3D +120=B0C)  =20
temp3:       +42=B0C  (limit =3D +100=B0C, critical =3D +120=B0C)  =20
temp4:       +44=B0C  (limit =3D +100=B0C, critical =3D +120=B0C)  =20

Here is the output from dmidecode:
# dmidecode  =20
# dmidecode 1.8
BIOS32 Service Directory present.
        Calling Interface Address: 0x000F0010
PCI Interrupt Routing 1.0 present.
        Table Size: 288 bytes
        Router ID: 00:0f.0
        Exclusive IRQs: None
        Compatible Router: 1166:0201
PNP 1.0 present.
        Event Notification: Not Supported
        Real Mode Code Address: F000:4932
        Real Mode Data Address: F000:0000
        Protected Mode Code Address: 0x000F495A
        Protected Mode Data Address: 0x000F0000

/Magnus Forsstr=F6m
