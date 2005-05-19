From: robs@multiplayer.it (Roberto Sebastiano)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: as99127f bug?
Message-Id: <1070210177.1636.43.camel@newdeal>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031130134504.142f7cde.khali@linux-fr.org>
In-Reply-To: <20031130134504.142f7cde.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Il dom, 2003-11-30 alle 15:24, Jean Delvare ha scritto:
> > Also, fan1 is wrong. I use a thermaltake silent boost, it never
> > reaches 3000 RPM
>=20
> I'm clueless. What does the BIOS say about it?
For a7n8x-x fan1_div is surely 4
But:

with fan1_div 2 in /etc/sensors.conf
  newdeal:/home/robs# sensors -s
  newdeal:/home/robs# sensors
  ...
  as99127f-i2c-1-2d
  ...
  fan1:     5000 RPM  (min =3D 2657 RPM, div =3D 2)                    =20


with fan1_div 4 in /etc/sensors.conf
  newdeal:/home/robs# sensors -s
  newdeal:/home/robs# sensors
  eeprom-i2c-0-51
  ...
  as99127f-i2c-1-2d
  ...
  fan1:     2463 RPM  (min =3D 1328 RPM, div =3D 4)                    =20
 =20
  (second run with no pause and no change in sensors.conf)
  newdeal:/home/robs# sensors
  ...
  as99127f-i2c-1-2d
  ...
  fan1:     4963 RPM  (min =3D 1328 RPM, div =3D 4)                    =20




--=20
Roberto Sebastiano <robs@multiplayer.it>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Questa parte del messaggio =3D?ISO-8859-1?Q?=E8?=3D firmata
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031130=
/8613d573/attachment.bin
