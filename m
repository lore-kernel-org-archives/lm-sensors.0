From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Linux device number bug report
Message-Id: <3FF1F578.2060908@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <00b901c3cc2b$05eeec30$6f01a8c0@zj>
In-Reply-To: <00b901c3cc2b$05eeec30$6f01a8c0@zj>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Our package only works on 2.4 kernels.
Issues such as this get fixed as drivers are ported to 2.6.
See the 2.6 kernel source tree for examples.

Zhang Jun wrote:
> Hello,
>=20
> I have some questions about device number extension.
>=20
> In Linux kernel 2.6, device number will be extended from 16-bit to 32-bit=
. All utilities and libraries should make corresponding extension for this =
new feature in kernel 2.6.=20
>=20
> I find that =A1=B0lm_sensors-2.8.1-2.4.23=A1=B1 considers and operates de=
vice number as 16-bit in following places:
> In file kernel/chips/smbus-arp.c: 99
>     u16 dev_int;=20
> "u16" is defined as unsigned short type. It seems not to correspond to de=
vice number extension.
>=20
> In file kernel/chips/smbus-arp.c: 376=20
>     data->dev[newdev].dev_int =3D (blk[6] << 8) | blk[7];=20
> As following, "major" should be 12-bit, and "minor" should be 20-bit.=20
>     mmmm mmmm mmmm MMMM MMMM MMMM mmmm mmmm
> "M" means major device number.
> "m" means minor device number.
> But this expression considers both major number and minor number as 8-bit=
. It seems not to correspond to device number extension.
>=20
> In file kernel/busses/i2c-piix4.c: 49
>     const unsigned short dev;
> This definition seems not to correspond to device number extension.
>=20
> Since I didn=A1=AFt find any information about this aspect in homepage of=
 this package, I wonder whether the latest version has completed the device=
 number extension? If not, will it be completed in the future? And when?
>=20
> Looking forward to answering.
>=20
>=20
>=20
> Regards,
> Zhang Jun
>=20
> --------------------------------------------------
> Zhang Jun
> Dept. of Technology and Development=20
> Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
> No. 16-5, Guanzhou Rd., Nanjing, P.R.China=20
> PHONE: +86+25-6630523-652=20
> FUJITSU INTERNAL: 79955-652=20
> FAX: +86+25-3317685 =20
> Mail: zhangjun@nanjing-fnst.com=20
> --------------------------------------------------
>=20
>=20
