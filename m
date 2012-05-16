From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 May 2012 09:23:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Drop uart6 condition for vin5&vin6 for IT8783F
Message-Id: <20120516112317.6969447e@endymion.delvare>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/bR/jIxVj_th7wN1K5KJmwqh"
List-Id: <lm-sensors.vger.kernel.org>
References: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
In-Reply-To: <50AE10ED-22C6-474A-90F2-81685F17B042@extracloud.de>
To: lm-sensors@vger.kernel.org

--MP_/bR/jIxVj_th7wN1K5KJmwqh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wed, 16 May 2012 08:52:31 +0200, Jean Delvare wrote:
> On Tue, 15 May 2012 12:51:08 -0700, Guenter Roeck wrote:
> > The data sheet says, with Register 0x27/Bit 0:
> >=20
> > Function Selection of Pin 93 (FSP)
> > 0: VIN5/FAN_TAC3/SIN6
> > If bit 2 of index 2Ch is 1, FAN_TAC3/SIN6 input is enabled; otherwise
> > select VIN5 input.
> > 1: GP30
> >=20
> > Assuming the above is correct, I think I'll rename "uart6" to "fan3" and
> > use
> >=20
> > 	fan3 =3D reg2C & (1 << 2);
> > ...
> > 	/* Check if fan3 is there or not */
> > 	if ((reg27 & (1 << 0)) || !fan3)
> >                 sio_data->skip_fan |=3D (1 << 2);
> > ...
> > 	if ((reg27 & (1 << 0)) || fan3)
> > 		sio_data->skip_in |=3D (1 << 5); /* No VIN5 */
> >=20
> > Does that make sense ?
>=20
> That's what the datasheet says, at least. I find it weird that enabling
> UART6 has an effect on VIN5 vs. FAN3_TAC, especially when UART6 pins
> can be remapped to a completely different location, but maybe this is
> really how the chip works.
>=20
> I think I wouldn't introduce variable fan3, as it is kind of a
> misnomer, and a proper name would be overly long. But this is an
> implementation detail.
>=20
> Bj=C3=B6rn, what is your design using pin 93 for?

I've updated the driver at
http://khali.linux-fr.org/devel/misc/it87/

with Bj=C3=B6rn's patch updated per the discussion above. Bj=C3=B6rn, can y=
ou
please give it a try and confirm it works for you?

Guenter, I attach the delta between your code and my standalone driver.
This is what could be folded into your previous patches, unless you no
longer want to touch them.

--=20
Jean Delvare

--MP_/bR/jIxVj_th7wN1K5KJmwqh
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=it87-fix-uart6-on-IT8783.patch

--- linux-3.4-rc7.orig/drivers/hwmon/it87.c	2012-05-16 08:53:21.000000000 +0200
+++ linux-3.4-rc7/drivers/hwmon/it87.c	2012-05-16 09:36:31.828155337 +0200
@@ -1744,7 +1744,6 @@ static int __init it87_find(unsigned sho
 		sio_data->beep_pin = superio_inb(IT87_SIO_BEEP_PIN_REG) & 0x3f;
 	} else if (sio_data->type == it8783) {
 		int reg25, reg27, reg2A, reg2C, regEF;
-		bool uart6;
 
 		sio_data->skip_vid = 1;	/* No VID */
 
@@ -1756,10 +1755,8 @@ static int __init it87_find(unsigned sho
 		reg2C = superio_inb(IT87_SIO_PINX2_REG);
 		regEF = superio_inb(IT87_SIO_SPI_REG);
 
-		uart6 = reg2C & (1 << 2);
-
 		/* Check if fan3 is there or not */
-		if ((reg27 & (1 << 0)) || !uart6)
+		if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2)))
 			sio_data->skip_fan |= (1 << 2);
 		if ((reg25 & (1 << 4))
 		    || (!(reg2A & (1 << 1)) && (regEF & (1 << 0))))
@@ -1772,11 +1769,11 @@ static int __init it87_find(unsigned sho
 			sio_data->skip_pwm |= (1 << 1);
 
 		/* VIN5 */
-		if ((reg27 & (1 << 0)) || uart6)
+		if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)))
 			sio_data->skip_in |= (1 << 5); /* No VIN5 */
 
 		/* VIN6 */
-		if ((reg27 & (1 << 1)) || uart6)
+		if (reg27 & (1 << 1))
 			sio_data->skip_in |= (1 << 6); /* No VIN6 */
 
 		/*

--MP_/bR/jIxVj_th7wN1K5KJmwqh
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--MP_/bR/jIxVj_th7wN1K5KJmwqh--
