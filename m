From: ladis@linux-mips.org (Ladislav Michl)
Date: Mon, 24 Oct 2005 16:01:34 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] i2c: Fix incorrect ID uses
Message-Id: <20051024140042.GA8183@orphique>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051022154830.0b7688ab.khali@linux-fr.org>
In-Reply-To: <20051022154830.0b7688ab.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Sat, Oct 22, 2005 at 03:48:30PM +0200, Jean Delvare wrote:
> Hi all,

Hi Jean,

> I am enqueuing the following patch. Driver authors are invited to Ack
> their respective parts, or voice in if anything doesn't look OK.
>=20
> Thanks.
>=20
> Fix several incorrect uses and redefinitions of i2c IDs.
> In particular:
> * i2c algorithm IDs are gone;
> * i2c IDs must not be defined outside of i2c-id.h.
>=20
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> CC: Henk Vergonet <henk@god.dyndns.org>
> CC: Antonino Daplas <adaplas@pol.net>
> CC: Mark McClelland <mark@alpha.dyndns.org>
> CC: Ladislav Michl <ladis@linux-mips.org>
> CC: Mikael Nousiainen <tmnousia@cc.hut.fi>
>=20
> ---
>  drivers/i2c/busses/i2c-prosavage.c |    5 -----
>  drivers/media/video/indycam.c      |    4 +---
>  drivers/media/video/saa7191.c      |    8 +++-----
>  drivers/video/i810/i810-i2c.c      |    5 +----
>  include/media/ovcamchip.h          |   14 --------------
>  5 files changed, 5 insertions(+), 31 deletions(-)
[snip]
> --- linux-2.6.14-rc4.orig/drivers/media/video/indycam.c	2005-10-18 22:49:=
10.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/media/video/indycam.c	2005-10-22 14:23:00.00=
0000000 +0200
> @@ -44,8 +44,6 @@
>  #define indycam_regdump(client)
>  #endif
> =20
> -#define VINO_ADAPTER	(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
> -
>  struct indycam {
>  	struct i2c_client *client;
>  	int version;
> @@ -300,7 +298,7 @@
>  static int indycam_probe(struct i2c_adapter *adap)
>  {
>  	/* Indy specific crap */
> -	if (adap->id =3D VINO_ADAPTER)
> +	if (adap->id =3D I2C_HW_SGI_VINO)
>  		return indycam_attach(adap, INDYCAM_ADDR, 0);
>  	/* Feel free to add probe here :-) */
>  	return -ENODEV;
> --- linux-2.6.14-rc4.orig/drivers/media/video/saa7191.c	2005-10-18 22:49:=
10.000000000 +0200
> +++ linux-2.6.14-rc4/drivers/media/video/saa7191.c	2005-10-22 14:23:00.00=
0000000 +0200
> @@ -33,8 +33,6 @@
>  MODULE_AUTHOR("Mikael Nousiainen <tmnousia@cc.hut.fi>");
>  MODULE_LICENSE("GPL");
> =20
> -#define VINO_ADAPTER	(I2C_ALGO_SGI | I2C_HW_SGI_VINO)
> -
>  struct saa7191 {
>  	struct i2c_client *client;
> =20
> @@ -337,7 +335,7 @@
>  static int saa7191_probe(struct i2c_adapter *adap)
>  {
>  	/* Always connected to VINO */
> -	if (adap->id =3D VINO_ADAPTER)
> +	if (adap->id =3D I2C_HW_SGI_VINO)
>  		return saa7191_attach(adap, SAA7191_ADDR, 0);
>  	/* Feel free to add probe here :-) */
>  	return -ENODEV;
> @@ -364,7 +362,7 @@
> =20
>  		cap->flags  =3D VIDEO_DECODER_PAL | VIDEO_DECODER_NTSC |
>  			      VIDEO_DECODER_SECAM | VIDEO_DECODER_AUTO;
> -		cap->inputs =3D (client->adapter->id =3D VINO_ADAPTER) ? 2 : 1;
> +		cap->inputs =3D (client->adapter->id =3D I2C_HW_SGI_VINO) ? 2 : 1;
>  		cap->outputs =3D 1;
>  		break;
>  	}
> @@ -422,7 +420,7 @@
>  		int *iarg =3D arg;
> =20
>  		switch (client->adapter->id) {
> -		case VINO_ADAPTER:
> +		case I2C_HW_SGI_VINO:
>  			return saa7191_set_input(client, *iarg);
>  		default:
>  			if (*iarg !=3D 0)

Please exclude above change. I already fixed driver in linux-mips.org
CVS (git these times) [1] and change was sent upstream [2] by Ralf Baechle
- linux-mips maintainer.

[1] http://www.linux-mips.org/git?p=3Dlinux.git;a=3Dcommit;h=926d27c6a32290=
2c5c3adef607c45f0f36ee21fb
[2] http://marc.theaimsgroup.com/?l=3Dlinux-video&m=112954391812094&w=3D2

Best regards,
	ladis
