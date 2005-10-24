From: mark@alpha.dyndns.org (Mark McClelland)
Date: Mon, 24 Oct 2005 15:12:03 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <435CDD72.7020501@alpha.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051022154830.0b7688ab.khali@linux-fr.org>
In-Reply-To: <20051022154830.0b7688ab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi all,
>
> I am enqueuing the following patch. Driver authors are invited to Ack
> their respective parts, or voice in if anything doesn't look OK.
>
> Thanks.
>
> Fix several incorrect uses and redefinitions of i2c IDs.
> In particular:
> * i2c algorithm IDs are gone;
> * i2c IDs must not be defined outside of i2c-id.h.
>
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
>
>  =20
(...)
> --- linux-2.6.14-rc4.orig/include/media/ovcamchip.h	2004-12-24 22:35:40.0=
00000000 +0100
> +++ linux-2.6.14-rc4/include/media/ovcamchip.h	2005-10-22 14:23:00.000000=
000 +0200
> @@ -17,20 +17,6 @@
>  #include <linux/videodev.h>
>  #include <linux/i2c.h>
> =20
> -/* Remove these once they are officially defined */
> -#ifndef I2C_DRIVERID_OVCAMCHIP
> -	#define I2C_DRIVERID_OVCAMCHIP	0xf00f
> -#endif
> -#ifndef I2C_HW_SMBUS_OV511
> -	#define I2C_HW_SMBUS_OV511	0xfe
> -#endif
> -#ifndef I2C_HW_SMBUS_OV518
> -	#define I2C_HW_SMBUS_OV518	0xff
> -#endif
> -#ifndef I2C_HW_SMBUS_OVFX2
> -	#define I2C_HW_SMBUS_OVFX2	0xfd
> -#endif
> -
>  /* --------------------------------- */
>  /*           ENUMERATIONS            */
>  /* --------------------------------- */
>
>  =20

Acked-by: Mark McClelland <mark@alpha.dyndns.org>

Thanks for cleaning this up!

BTW, someone might want to take a look at include/media/id.h. It could=20
stand to be cleaned up or deleted altogether:

=3D=3D=3D
/* FIXME: this temporarely, until these are included in linux/i2c-id.h */

<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l5>=20

<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l6>/*=20
drivers */
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l7>#ifndef=20
I2C_DRIVERID_TVMIXER
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l8>#=20
define I2C_DRIVERID_TVMIXER I2C_DRIVERID_EXP0
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l9>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l10>#ifndef=20
I2C_DRIVERID_TVAUDIO
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l11>#=20
define I2C_DRIVERID_TVAUDIO I2C_DRIVERID_EXP1
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l12>#endif

<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l13>=20

<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l14>/*=20
chips */
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l15>#ifndef=20
I2C_DRIVERID_DPL3518
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l16>#=20
define I2C_DRIVERID_DPL3518 I2C_DRIVERID_EXP2
#endif
#ifndef I2C_DRIVERID_TDA9873
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l19>#=20
define I2C_DRIVERID_TDA9873 I2C_DRIVERID_EXP3
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l20>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l21>#ifndef=20
I2C_DRIVERID_TDA9875
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l22>#=20
define I2C_DRIVERID_TDA9875 I2C_DRIVERID_EXP0+4
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l23>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l24>#ifndef=20
I2C_DRIVERID_PIC16C54_PV951
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l25>#=20
define I2C_DRIVERID_PIC16C54_PV951 I2C_DRIVERID_EXP0+5
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l26>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l27>#ifndef=20
I2C_DRIVERID_TDA7432
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l28>#=20
define I2C_DRIVERID_TDA7432 I2C_DRIVERID_EXP0+6
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l29>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l30>#ifndef=20
I2C_DRIVERID_TDA9874
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l31>#=20
define I2C_DRIVERID_TDA9874 I2C_DRIVERID_EXP0+7
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l32>#endif
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l33>#ifndef=20
I2C_DRIVERID_SAA6752HS
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l34>#=20
define I2C_DRIVERID_SAA6752HS I2C_DRIVERID_EXP0+8
<http://www.kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=
=3Dblob;hm02c94cdc0db4dcb5b888ec95e2fe5f4f4beeae;hb=BA9e358fd04190a59e605c2=
963a15e014139a707;f=3Dinclude/media/id.h#l35>#endif
=3D=3D=3D
--
Mark McClelland
mark@alpha.dyndns.org
mark@ovcam.org
