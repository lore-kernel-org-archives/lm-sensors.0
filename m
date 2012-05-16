From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 16 May 2012 13:41:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Drop uart6 condition for vin5&vin6 for IT8783F
Message-Id: <20120516134126.GA28590@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
In-Reply-To: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-9"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, May 16, 2012 at 05:23:17AM -0400, Jean Delvare wrote:
> On Wed, 16 May 2012 08:52:31 +0200, Jean Delvare wrote:
> > On Tue, 15 May 2012 12:51:08 -0700, Guenter Roeck wrote:
> > > The data sheet says, with Register 0x27/Bit 0:
> > >=20
> > > Function Selection of Pin 93 (FSP)
> > > 0: VIN5/FAN_TAC3/SIN6
> > > If bit 2 of index 2Ch is 1, FAN_TAC3/SIN6 input is enabled; otherwise
> > > select VIN5 input.
> > > 1: GP30
> > >=20
> > > Assuming the above is correct, I think I'll rename "uart6" to "fan3" =
and
> > > use
> > >=20
> > > 	fan3 =3D reg2C & (1 << 2);
> > > ...
> > > 	/* Check if fan3 is there or not */
> > > 	if ((reg27 & (1 << 0)) || !fan3)
> > >                 sio_data->skip_fan |=3D (1 << 2);
> > > ...
> > > 	if ((reg27 & (1 << 0)) || fan3)
> > > 		sio_data->skip_in |=3D (1 << 5); /* No VIN5 */
> > >=20
> > > Does that make sense ?
> >=20
> > That's what the datasheet says, at least. I find it weird that enabling
> > UART6 has an effect on VIN5 vs. FAN3_TAC, especially when UART6 pins
> > can be remapped to a completely different location, but maybe this is
> > really how the chip works.
> >=20
> > I think I wouldn't introduce variable fan3, as it is kind of a
> > misnomer, and a proper name would be overly long. But this is an
> > implementation detail.
> >=20
> > Bj=F6rn, what is your design using pin 93 for?
>=20
> I've updated the driver at
> http://khali.linux-fr.org/devel/misc/it87/
>=20
> with Bj=F6rn's patch updated per the discussion above. Bj=F6rn, can you
> please give it a try and confirm it works for you?
>=20
> Guenter, I attach the delta between your code and my standalone driver.
> This is what could be folded into your previous patches, unless you no
> longer want to touch them.
>=20
Looks good. I'll fold it in. Thanks for taking care of it.

Guenter

> --=20
> Jean Delvare

> --- linux-3.4-rc7.orig/drivers/hwmon/it87.c	2012-05-16 08:53:21.000000000=
 +0200
> +++ linux-3.4-rc7/drivers/hwmon/it87.c	2012-05-16 09:36:31.828155337 +0200
> @@ -1744,7 +1744,6 @@ static int __init it87_find(unsigned sho
>  		sio_data->beep_pin =3D superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
>  	} else if (sio_data->type =3D=3D it8783) {
>  		int reg25, reg27, reg2A, reg2C, regEF;
> -		bool uart6;
> =20
>  		sio_data->skip_vid =3D 1;	/* No VID */
> =20
> @@ -1756,10 +1755,8 @@ static int __init it87_find(unsigned sho
>  		reg2C =3D superio_inb(IT87_SIO_PINX2_REG);
>  		regEF =3D superio_inb(IT87_SIO_SPI_REG);
> =20
> -		uart6 =3D reg2C & (1 << 2);
> -
>  		/* Check if fan3 is there or not */
> -		if ((reg27 & (1 << 0)) || !uart6)
> +		if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
>  			sio_data->skip_fan |=3D (1 << 2);
>  		if ((reg25 & (1 << 4))
>  		    || (!(reg2A & (1 << 1)) && (regEF & (1 << 0))))
> @@ -1772,11 +1769,11 @@ static int __init it87_find(unsigned sho
>  			sio_data->skip_pwm |=3D (1 << 1);
> =20
>  		/* VIN5 */
> -		if ((reg27 & (1 << 0)) || uart6)
> +		if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)))
>  			sio_data->skip_in |=3D (1 << 5); /* No VIN5 */
> =20
>  		/* VIN6 */
> -		if ((reg27 & (1 << 1)) || uart6)
> +		if (reg27 & (1 << 1))
>  			sio_data->skip_in |=3D (1 << 6); /* No VIN6 */
> =20
>  		/*


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
