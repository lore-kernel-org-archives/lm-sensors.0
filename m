From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 17:06:01 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add support for
Message-Id: <20111121180601.65e85ade@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 21 Nov 2011 08:47:00 -0800, Guenter Roeck wrote:
> On Mon, 2011-11-21 at 08:07 -0500, Jean Delvare wrote:
> > On Mon, 21 Nov 2011 10:43:39 +0100, Jean Delvare wrote:
> > > What about bit 3 (USF) in this enhanced configuration register? When
> > > set, it would affect the way we encode and decode _max and _crit
> > > temperature limits, right?
> >=20
> > BTW, if you agree but don't have time to work on this, I would be
> > perfectly fine with a check at probe time that would complain (and
> > eventually bail out) if the way the chip is configured is not properly
> > supported by the driver. If anyone needs the feature, it can be added
> > later.
> >=20
>=20
> Reminds me:
>=20
> root@server:/sys/class/hwmon/hwmon2/device# sensors lm96163-i2c-15-4c
> lm96163-i2c-15-4c
> Adapter: i2c-diolan-u2c:004
> fan1:           0 RPM  (min =3D    0 RPM)
> temp1:        +23.0=B0C  (high =3D +70.0=B0C)
> temp2:        +23.0=B0C  (low  =3D  +0.0=B0C, high =3D +85.0=B0C)
>                        (crit =3D +110.0=B0C, hyst =3D +100.0=B0C)
>=20
> root@server:/sys/class/hwmon/hwmon2/device# i2cdump -y -f 15 0x4c
> No size specified (using byte-data access)
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> 00: 17 17 80 86 08 46 00 55 00 86 08 46 00 55 00 00    ?????F.U.??F.U..
> 10: 20 00 00 00 00 00 a4 00 00 6e 00 00 00 00 00 00     .....?..n......
> 20: 00 0a 00 00 00 00 00 00 00 00 00 00 00 00 00 00    .?..............
> 30: 00 17 20 00 00 00 00 00 00 00 00 00 00 00 00 00    .? .............
> 40: 00 00 00 00 00 00 ff ff fc ff 20 3f 01 08 00 04    ........?. ???.?
> 50: 7f 3f 7f 3f 7f 3f 7f 3f 7f 3f 7f 3f 7f 3f 7f 3f    ????????????????
> 60: 7f 3f 7f 3f 7f 3f 7f 3f 00 00 00 00 00 00 00 00    ????????........
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01 49    ..............?I

Added to my collection, thank you :)

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
