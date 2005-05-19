From: zhangjun@nanjing-fnst.com (Zhang Jun)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: Linux device number bug report
Message-Id: <00b901c3cc2b$05eeec30$6f01a8c0@zj>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

I have some questions about device number extension.

In Linux kernel 2.6, device number will be extended from 16-bit to 32-bit. =
All utilities and libraries should make corresponding extension for this ne=
w feature in kernel 2.6.=20

I find that =A1=B0lm_sensors-2.8.1-2.4.23=A1=B1 considers and operates devi=
ce number as 16-bit in following places:
In file kernel/chips/smbus-arp.c: 99
    u16 dev_int;=20
"u16" is defined as unsigned short type. It seems not to correspond to devi=
ce number extension.

In file kernel/chips/smbus-arp.c: 376=20
    data->dev[newdev].dev_int =3D (blk[6] << 8) | blk[7];=20
As following, "major" should be 12-bit, and "minor" should be 20-bit.=20
    mmmm mmmm mmmm MMMM MMMM MMMM mmmm mmmm
"M" means major device number.
"m" means minor device number.
But this expression considers both major number and minor number as 8-bit. =
It seems not to correspond to device number extension.

In file kernel/busses/i2c-piix4.c: 49
    const unsigned short dev;
This definition seems not to correspond to device number extension.

Since I didn=A1=AFt find any information about this aspect in homepage of t=
his package, I wonder whether the latest version has completed the device n=
umber extension? If not, will it be completed in the future? And when?

Looking forward to answering.



Regards,
Zhang Jun

--------------------------------------------------
Zhang Jun
Dept. of Technology and Development=20
Nanjing Fujitsu Nanda Software Tech. Co., Ltd.(FNST)
No. 16-5, Guanzhou Rd., Nanjing, P.R.China=20
PHONE: +86+25-6630523-652=20
FUJITSU INTERNAL: 79955-652=20
FAX: +86+25-3317685 =20
Mail: zhangjun@nanjing-fnst.com=20
--------------------------------------------------
