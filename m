From: Bjoern Gerhart <oss@extracloud.de>
Date: Tue, 13 Mar 2012 18:43:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Add support for IT8781F, IT8782F, IT8783E/F
Message-Id: <CABRa2TJCnLH1YGMmSEaZsn0QbjNGZLepB8_awr5cfK-_8Rj-9g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1331180739-19470-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2012/3/8 Guenter Roeck <linux@roeck-us.net>:
> Assume all three are compatible and have the same functionality.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Bjoern Gerhart <oss@extracloud.de>
> ---
> This patch depends on the other pending changes for the it87 driver in my
> hwmon-next tree.
>
> =A0Documentation/hwmon/it87 | =A0 24 +++++++----
> =A0drivers/hwmon/it87.c =A0 =A0 | =A0 93 ++++++++++++++++++++++++++++++++=
++++++++++----
> =A02 files changed, 100 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/hwmon/it87 b/Documentation/hwmon/it87
> index 23b7def..b0c1dcd 100644
> --- a/Documentation/hwmon/it87
> +++ b/Documentation/hwmon/it87
> @@ -30,6 +30,10 @@ Supported chips:
> =A0 =A0 Prefix: 'it8728'
> =A0 =A0 Addresses scanned: from Super I/O config space (8 I/O ports)
> =A0 =A0 Datasheet: Not publicly available
> + =A0* IT8781F/IT8782F/IT8783E/F
> + =A0 =A0Prefix: 'it8783'
> + =A0 =A0Addresses scanned: from Super I/O config space (8 I/O ports)
> + =A0 =A0Datasheet: Not publicly available
> =A0 * SiS950 =A0 [clone of IT8705F]
> =A0 =A0 Prefix: 'it87'
> =A0 =A0 Addresses scanned: from Super I/O config space (8 I/O ports)
> @@ -75,7 +79,8 @@ Description
> =A0-----------
>
> =A0This driver implements support for the IT8705F, IT8712F, IT8716F,
> -IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E and SiS950 chips.
> +IT8718F, IT8720F, IT8721F, IT8726F, IT8728F, IT8758E, IT8781F, IT8782F,
> +IT8783E/F, and SiS950 chips.
>
> =A0These chips are 'Super I/O chips', supporting floppy disks, infrared p=
orts,
> =A0joysticks and other miscellaneous stuff. For hardware monitoring, they
> @@ -99,11 +104,11 @@ The IT8716F, IT8718F, IT8720F, IT8721F/IT8758E and l=
ater IT8712F revisions
> =A0have support for 2 additional fans. The additional fans are supported =
by the
> =A0driver.
>
> -The IT8716F, IT8718F, IT8720F and IT8721F/IT8758E, and late IT8712F and
> -IT8705F also have optional 16-bit tachometer counters for fans 1 to 3. T=
his
> -is better (no more fan clock divider mess) but not compatible with the o=
lder
> -chips and revisions. The 16-bit tachometer mode is enabled by the driver=
 when
> -one of the above chips is detected.
> +The IT8716F, IT8718F, IT8720F and IT8721F/IT8758E, IT8781F, IT8782F, IT8=
783E/F,
> +and late IT8712F and IT8705F also have optional 16-bit tachometer counte=
rs for
> +fans 1 to 3. This is better (no more fan clock divider mess) but not com=
patible
> +with the older chips and revisions. The 16-bit tachometer mode is enable=
d by the
> +driver when one of the above chips is detected.
>
> =A0The IT8726F is just bit enhanced IT8716F with additional hardware
> =A0for AMD power sequencing. Therefore the chip will appear as IT8716F
> @@ -131,9 +136,10 @@ inputs can measure voltages between 0 and 4.08 volts=
, with a resolution of
> =A00.016 volt (except IT8721F/IT8758E and IT8728F: 0.012 volt.) The batte=
ry
> =A0voltage in8 does not have limit registers.
>
> -On the IT8721F/IT8758E, some voltage inputs are internal and scaled insi=
de
> -the chip (in7, in8 and optionally in3). The driver handles this transpar=
ently
> -so user-space doesn't have to care.
> +On the IT8721F/IT8758E/IT8781F/IT8782F/IT8783E/F, some voltage inputs are
> +internal and scaled inside the chip (in7 (optional for IT8781/2/3), in8 =
and
> +optionally in3). The driver handles this transparently so user-space doe=
sn't
> +have to care.
>
> =A0The VID lines (IT8712F/IT8716F/IT8718F/IT8720F) encode the core voltag=
e value:
> =A0the voltage level your processor should work with. This is hardcoded by
> diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
> index 0b204e4..afaf19b 100644
> --- a/drivers/hwmon/it87.c
> +++ b/drivers/hwmon/it87.c
> @@ -19,6 +19,9 @@
> =A0* =A0 =A0 =A0 =A0 =A0 =A0IT8726F =A0Super I/O chip w/LPC interface
> =A0* =A0 =A0 =A0 =A0 =A0 =A0IT8728F =A0Super I/O chip w/LPC interface
> =A0* =A0 =A0 =A0 =A0 =A0 =A0IT8758E =A0Super I/O chip w/LPC interface
> + * =A0 =A0 =A0 =A0 =A0 =A0IT8781F =A0Super I/O chip w/LPC interface
> + * =A0 =A0 =A0 =A0 =A0 =A0IT8782F =A0Super I/O chip w/LPC interface
> + * =A0 =A0 =A0 =A0 =A0 =A0IT8783E/F Super I/O chip w/LPC interface
> =A0* =A0 =A0 =A0 =A0 =A0 =A0Sis950 =A0 A clone of the IT8705F
> =A0*
> =A0* =A0Copyright (C) 2001 Chris Gauthron
> @@ -59,7 +62,7 @@
>
> =A0#define DRVNAME "it87"
>
> -enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728 };
> +enum chips { it87, it8712, it8716, it8718, it8720, it8721, it8728, it878=
3 };
>
> =A0static unsigned short force_id;
> =A0module_param(force_id, ushort, 0);
> @@ -137,13 +140,19 @@ static inline void superio_exit(void)
> =A0#define IT8721F_DEVID 0x8721
> =A0#define IT8726F_DEVID 0x8726
> =A0#define IT8728F_DEVID 0x8728
> +#define IT8781F_DEVID 0x8781
> +#define IT8782F_DEVID 0x8782
> +#define IT8783E_DEVID 0x8783
> =A0#define IT87_ACT_REG =A00x30
> =A0#define IT87_BASE_REG 0x60
>
> =A0/* Logical device 7 registers (IT8712F and later) */
> +#define IT87_SIO_GPIO1_REG =A0 =A0 0x25
> =A0#define IT87_SIO_GPIO3_REG =A0 =A0 0x27
> =A0#define IT87_SIO_GPIO5_REG =A0 =A0 0x29
> +#define IT87_SIO_PINX1_REG =A0 =A0 0x2a =A0 =A0/* Pin selection */
> =A0#define IT87_SIO_PINX2_REG =A0 =A0 0x2c =A0 =A0/* Pin selection */
> +#define IT87_SIO_SPI_REG =A0 =A0 =A0 0xef =A0 =A0/* SPI function pin sel=
ect */
> =A0#define IT87_SIO_VID_REG =A0 =A0 =A0 0xfc =A0 =A0/* VID value */
> =A0#define IT87_SIO_BEEP_PIN_REG =A00xf6 =A0 =A0/* Beep pin mapping */
>
> @@ -313,8 +322,12 @@ static u8 in_to_reg(const struct it87_data *data, in=
t nr, long val)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lsb =3D 24;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0lsb =3D 12;
> - =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsb =3D 16;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->in_scaled & (1 << nr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsb =3D 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lsb =3D 16;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0val =3D DIV_ROUND_CLOSEST(val, lsb);
> =A0 =A0 =A0 =A0return SENSORS_LIMIT(val, 0, 255);
> @@ -327,8 +340,12 @@ static int in_from_reg(const struct it87_data *data,=
 int nr, int val)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return val * 24;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return val * 12;
> - =A0 =A0 =A0 } else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val * 16;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->in_scaled & (1 << nr))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val * 32;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return val * 16;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static inline u8 FAN_TO_REG(long rpm, int div)
> @@ -407,7 +424,8 @@ static inline int has_16bit_fans(const struct it87_da=
ta *data)
> =A0 =A0 =A0 =A0 =A0 =A0|| data->type =3D=3D it8718
> =A0 =A0 =A0 =A0 =A0 =A0|| data->type =3D=3D it8720
> =A0 =A0 =A0 =A0 =A0 =A0|| data->type =3D=3D it8721
> - =A0 =A0 =A0 =A0 =A0 || data->type =3D=3D it8728;
> + =A0 =A0 =A0 =A0 =A0 || data->type =3D=3D it8728
> + =A0 =A0 =A0 =A0 =A0 || data->type =3D=3D it8783;
> =A0}
>
> =A0static inline int has_old_autopwm(const struct it87_data *data)
> @@ -1651,6 +1669,11 @@ static int __init it87_find(unsigned short *addres=
s,
> =A0 =A0 =A0 =A0case IT8728F_DEVID:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sio_data->type =3D it8728;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> + =A0 =A0 =A0 case IT8781F_DEVID:
> + =A0 =A0 =A0 case IT8782F_DEVID:
> + =A0 =A0 =A0 case IT8783E_DEVID:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->type =3D it8783;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0case 0xffff: =A0 =A0/* No device at all */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit;
> =A0 =A0 =A0 =A0default:
> @@ -1686,6 +1709,54 @@ static int __init it87_find(unsigned short *addres=
s,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* The IT8705F has a different LD number f=
or GPIO */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0superio_select(5);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sio_data->beep_pin =3D superio_inb(IT87_SI=
O_BEEP_PIN_REG) & 0x3f;
> + =A0 =A0 =A0 } else if (sio_data->type =3D=3D it8783) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int reg25, reg27, reg2A, reg2C, regEF;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->skip_vid =3D 1; /* No VID */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 superio_select(GPIO);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg25 =3D superio_inb(IT87_SIO_GPIO1_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg27 =3D superio_inb(IT87_SIO_GPIO3_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg2A =3D superio_inb(IT87_SIO_PINX1_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg2C =3D superio_inb(IT87_SIO_PINX2_REG);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 regEF =3D superio_inb(IT87_SIO_SPI_REG);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if fan3 is there or not */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((reg27 & (1 << 0)) || !(reg2C & (1 << 2=
)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->skip_fan |=3D (1 =
<< 2);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((reg25 & (1 << 4))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || (!(reg2A & (1 << 1)) && (regEF &=
 (1 << 0))))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->skip_pwm |=3D (1 =
<< 2);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Check if fan2 is there or not */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg27 & (1 << 7))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->skip_fan |=3D (1 =
<< 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg27 & (1 << 3))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->skip_pwm |=3D (1 =
<< 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* VIN5 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((reg27 & (1 << 0)) || (reg2C & (1 << 2)=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* No VIN5 */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* VIN6 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((reg27 & (1 << 1)) || (reg2C & (1 << 2)=
))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* No VIN6 */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* VIN7
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Does not depend on bit 2 of Reg2C, con=
trary to datasheet.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg27 & (1 << 2))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* No VIN7 */
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg2C & (1 << 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->internal |=3D (1 =
<< 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg2C & (1 << 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->internal |=3D (1 =
<< 1);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->beep_pin =3D superio_inb(IT87_SIO=
_BEEP_PIN_REG) & 0x3f;
> +
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int reg;
>
> @@ -1823,6 +1894,7 @@ static int __devinit it87_probe(struct platform_dev=
ice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"it8720",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"it8721",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"it8728",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 "it8783",
> =A0 =A0 =A0 =A0};
>
> =A0 =A0 =A0 =A0res =3D platform_get_resource(pdev, IORESOURCE_IO, 0);
> @@ -1867,6 +1939,11 @@ static int __devinit it87_probe(struct platform_de=
vice *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->in_scaled |=3D (1 <<=
 7); =A0 =A0/* in7 is VSB */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (sio_data->internal & (1 << 2))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->in_scaled |=3D (1 <<=
 8); =A0 =A0/* in8 is Vbat */
> + =A0 =A0 =A0 } else if (sio_data->type =3D=3D it8783) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sio_data->internal & (1 << 0))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->in_scaled |=3D (1 << =
3); =A0 =A0/* in3 is VCC5V */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (sio_data->internal & (1 << 1))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->in_scaled |=3D (1 << =
7); =A0 =A0/* in7 is VCCH5V */
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Initialize the IT87 chip */
> @@ -2143,8 +2220,8 @@ static void __devinit it87_init_device(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0it87_write_value(data, IT8=
7_REG_FAN_16BIT,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 tmp | 0x07);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IT8705F only supports three fans. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->type !=3D it87) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* IT8705F and IT8783E/F only support three=
 fans. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->type !=3D it87 && data->type !=3D=
 it8783) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp & (1 << 4))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->has_=
fan |=3D (1 << 3); /* fan4 enabled */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tmp & (1 << 5))
> --
> 1.7.5.4
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
