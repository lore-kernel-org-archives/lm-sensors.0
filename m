From: Rainer Birkenmaier <rainer.birkenmaier@siemens.com>
Date: Fri, 27 Jul 2007 12:24:23 +0000
Subject: Re: [lm-sensors] [PATCH] Fix regression caused by typo in lm90.c
Message-Id: <1185539063.6855.2.camel@ella.mchp.siemens.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726230422.2955.70451.sendpatchset@localhost.localdomain>
In-Reply-To: <20070726230422.2955.70451.sendpatchset@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guillaume Chazarain <guichaz@yahoo.fr>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi,

my original patch for this didn't have that typo, however I had spelled
it in small letters instead of capital letters. So I guess, the typo
sneaked in while switching from small to capital letter.

Main message: I can confirm that it actually is a typo :)

have a great day
/Rainer

Am Freitag, den 27.07.2007, 01:04 +0200 schrieb Guillaume Chazarain:
> Hi,
>=20
> The commit http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6=
.git;a=3Dcommitdiff;h2c82a934759b2c9939c9e25865c2d7d1204b9e8
> broke lm90 for my (Asus V6VA) laptop.
>=20
> Before 2.6.23-rc1 and with the following patch, I get:
>=20
> [g ~]$ sensors
> max6657-i2c-0-4c
> Adapter: SMBus I801 adapter at 0400
> M/B Temp:    +64=C2=B0C  (low  =3D    +0=C2=B0C, high =3D  +127=C2=B0C)  =
=20
> CPU Temp:  +78.9=C2=B0C  (low  =3D +73.2=C2=B0C, high =3D +88.2=C2=B0C)  =
=20
> M/B Crit:   +105=C2=B0C  (hyst =3D   +95=C2=B0C)                  =20
> CPU Crit:   +105=C2=B0C  (hyst =3D   +95=C2=B0C)                  =20
>=20
> Which regressed into:
>=20
> [g ~]$ sensors
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.
> zsh: 2701 exit 1     sensors
>=20
> and dmesg contains:
>=20
> i2c-adapter i2c-0: Unsupported chip (man_id=3D0x4D, chip_id=3D0x4D).
>=20
> It seems to be a typo, as address 0X4F is mentionned nowhere else in the =
file,
> and my chip is actually at 0x4C.
>=20
> Thanks.
>=20
> Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
> ---
>=20
> diff -r 4cad6fced1a8 drivers/hwmon/lm90.c
> --- a/drivers/hwmon/lm90.c	Thu Jul 26 13:44:58 2007 -0700
> +++ b/drivers/hwmon/lm90.c	Tue Jul 24 00:02:52 2007 +0200
> @@ -585,7 +585,7 @@ static int lm90_detect(struct i2c_adapte
>  			 * those of the man_id register.
>  			 */
>  			if (chip_id =3D man_id
> -			 && (address =3D 0x4F || address =3D 0x4D)
> +			 && (address =3D 0x4C || address =3D 0x4D)
>  			 && (reg_config1 & 0x1F) =3D (man_id & 0x0F)
>  			 && reg_convrate <=3D 0x09) {
>  			 	kind =3D max6657;
--=20
>>> SIEMENS AG - Corporate Technology (CT SE 2)        <<<
>>> Dipl.-Inf. Rainer Birkenmaier                      <<<
>>>              email: rainer.birkenmaier@siemens.com <<<
>>>     phone: +49-89-636-53725  fax: +49-89-636-45450 <<<

Siemens Aktiengesellschaft: Vorsitzender des Aufsichtsrats: Gerhard Cromme
Vorstand: Peter L=F6scher, Vorsitzender; Johannes Feldmayer, Heinrich
Hiesinger, Joe Kaeser, Rudi Lamprecht, Eduardo Montes,=20
J=FCrgen Radomski, Erich R. Reinhardt, Hermann Requardt, Uriel J. Sharef,
Klaus Wucherer
Sitz der Gesellschaft: Berlin und M=FCnchen; Registergericht: Berlin
Charlottenburg, HRB 12300, M=FCnchen, HRB 6684
WEEE-Reg.-Nr. DE 23691322


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
