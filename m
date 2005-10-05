From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 05 Oct 2005 17:22:52 +0000
Subject: [lm-sensors] Myson MTP008 driver ported to 2.6 kernel
Message-Id: <sKVXTKHG.1128525132.5833240.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051004125511.GI7154@kira.glasswings.com.au>
In-Reply-To: <20051004125511.GI7154@kira.glasswings.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org


Hi Andrew, Helge,

Here is a preliminary review of Andrew's version of the driver, so that
you can fix all the problems I've noticed when porting the code to work
with 2.6.14-rc3.

Note that I *know* that some of the bugs are not yours and were already
in the linux 2.4 driver. We still need to fix them for 2.6, and ideally
backport the fixes to lm_sensors CVS for 2.4.

Helge: As it seems you will be the one working on this, feel free to
start from your own code rather than Andrew's if you feel more
comfortable that way. I don't really care, as long as the result is
good :) Some of my comments below seem to apply to your code as well
anyway.

> #include <linux/i2c-sensor.h>

This is now linux/hwmon.h. You also lack linux/jiffies.h and linux/err.h,
which you will need.

> /* Addresses to scan */
> static unsigned short normal_i2c[] =3D {0x2c, 0x2e, I2C_CLIENT_END};

0x2d is missing.

> static unsigned int normal_isa[] =3D {I2C_CLIENT_ISA_END};

No more needed in 2.6.14.

> #define MTP008_REG_SMI_MASK1		0x43
> #define MTP008_REG_SMI_MASK2		0x44
>=20
> #define MTP008_REG_NMI_MASK1		0x45
> #define MTP008_REG_NMI_MASK2		0x46

Please don't define things you don't use.

> static inline u8 FAN_TO_REG(long rpm, int div)
> {
> 	if (rpm <=3D 0)
> 		return 255;
>=20
> 	rpm =3D SENSORS_LIMIT(rpm, 1, 1000000);

This call to SENSORS_LIMIT is not needed as far as I can see.

> #define FAN_FROM_REG(val, div)	((val) =3D 0 ? -1	      \
> 					    : (val) =3D 255 ? 0	      \
> 							   : 1350000 /	  \
> 							   ((val) * (div)) \
> 				)

What an awful indentation. Please fix.

> #define TEMP_TO_REG(val)	(					\	> 			 (val) < 0					\
> 				    ? SENSORS_LIMIT(((val) - 500) / 1000, \
> 						    0, 255) \
> 				    : SENSORS_LIMIT(((val) + 500) / 1000, \
> 						    0, 255) \
>				)

This one is clearly broken for negative temperatures and positive
temperatures between 128 and 255 degrees.

> #define TEMP_FROM_REG(val)	(					\
> 				 (					\
> 				  (val) > 0x80 ? (val) - 0x100		\
> 					       : (val)			\
> 				 ) * 1000				\
> 				)

The conditional would not be needed if you were using an s8 to store the
value rather than an u8.

> #define VID_FROM_REG(val)	((val) =3D 0x1f				\
> 					 ? 0				\
> 					 : (val) < 0x10 ? 2050 - (val) * 50 \
> 							: 5100 - (val) * 100)

Please include linux/hwmon-vid.h instead and use the vid_from_reg
function with vrm=82.

> #define DIV_TO_REG(val)		((val) =3D 8 ? 3		     \
> 					    : (val) =3D 4 ? 2	     \
> 				                : (val) =3D 2 ? 1     \
> 						      : 0)

This one is no more used (which is great, your reimplementation is much
better.)

> /*
>  * Alarms (interrupt status).
>  */
> #define ALARMS_FROM_REG(val)	(val)
>=20
> /*
>  * Beep controls.
>  */
> #define BEEPS_FROM_REG(val)	(val)
> #define BEEPS_TO_REG(val)	(val)

Useless, don't define these, use the value directly.

> #define SENS_FROM_REG(val)	((val) =3D 0 ? 0	: ((val) ^ 0x03))
> #define SENS_TO_REG(val)	SENS_FROM_REG(val)

This looks like a trick. Don't use tricks. You're really not saving
anything, but are increasing the chances that a bug sneaks in.

> struct mtp008_data {
> 	struct i2c_client client;
> 	enum chips type;

I doubt you actually need to remember the type, as only one type is
supported.

> 	u8 pwm[4];				/* Register value */

I see only 3 PWM channels.

> static ssize_t show_in(struct device *dev, char *buf, const int nr)
> {
> 	struct mtp008_data *data =3D mtp008_update_device(dev);
> 	int result =3D 0;
> 	if ((nr !=3D 4 && nr !=3D 5) || data->sens[nr - 3] =3D 0)
> 		result =3D IN_FROM_REG(data->in[nr]);
> 	return sprintf(buf, "%d\n", result);
> }

A note on hardware layout. As I understand it, the MTP008 has some pins
which can have different functions. The original driver gave the user
the possibility to change that, right? I do not think this is the
correct approach. In the real world, the hardware layout is defined and
doesn't change. The BIOS is supposed to properly setup the chip
according to this. Unless you have evidences that systems exists with
MTP008 chips, those BIOSes do NOT properly initialize the chip, I would
like the driver to trust the original settings, and stick to them. This
is less error-prone for the user, and should save some code and memory.

If we go that way, then you do not have to handle the conditions in each
callback function. Simply do not create the sysfs files which do not
match the current setup (that is, create in4* or temp2*, but not both
sets.)

> 	return sprintf(buf,"%d\n", FAN_FROM_REG(data->fan_min[nr],

Coding style: space after comma.

> 	data->pwm[nr-1] =3D PWM_TO_REG(val);
> 	mtp008_write_value(client, MTP008_REG_PWM_CTRL(nr), data->pwm[nr]);

nr vs. nr-1, doesn't look correct.

> int mtp008_detect(struct i2c_adapter *adapter, int address, int kind)
> {
> 	const char *client_name =3D "";

Useless initialization. In fact you don't need this variable at all, you
can pass the string to strlcpy directly.

> 	if (!(data =3D kmalloc(sizeof(struct mtp008_data), GFP_KERNEL))) {
> 		err =3D -ENOMEM;
> 		goto exit;
> 	}
> 	memset(data, 0, sizeof(struct mtp008_data));

The current trend is to use kzalloc instead of kmalloc+memset. There is a
pending patch to convert all hwmon drivers.

> 	/* Remaining detection. */
> 	if (kind < 0) {
> 	   if (mtp008_read_value(new_client, MTP008_REG_CHIPID) !=3D 0xac) {
> 			err =3D -ENODEV;
> 			goto exit_free;
> 		}
> 	}

This is a bit cheap, misdetections could happen. You should at least
check that register 0x48 holds the device address. Maybe there are other
bits which are known and you could check them too.

Your detection function lacks the class registration which was introduced
recently. See any hwmon driver in 2.6.14-rc3 for an example. Likewise,
the client deregistration will need class deregistration code.

> 	if ((err =3D i2c_detach_client(client))) {
> 		dev_err(&client->dev,
> 		    "Client deregistration failed, client not detached.\n");
> 		return err;
> 	}

Drop the error message, it was refactored into i2c_detach_client itself.

> static int mtp008_read_value(struct i2c_client *client, u8 reg)
> {
> 	return i2c_smbus_read_byte_data(client, reg) & 0xff;
> }

The masking can't be correct (it's either unneeded, or dangerous).

I see no point in having one line read and write functions, calling
i2c_smbus_{read,write}_byte_data directly would be more efficient.

> static void mtp008_init_client(struct i2c_client *client)
> {
> 	struct mtp008_data *data =3D i2c_get_clientdata(client);
> 	u8 save1, save2;
>=20
> 	/*
> 	 * Initialize the Myson MTP008 hardware monitoring chip.
> 	 * Save the pin settings that the BIOS hopefully set.
> 	 */
> 	save1 =3D mtp008_read_value(client, MTP008_REG_PIN_CTRL1);
> 	save2 =3D mtp008_read_value(client, MTP008_REG_PIN_CTRL2);
> 	mtp008_write_value(client, MTP008_REG_CONFIG,
> 	     (mtp008_read_value(client, MTP008_REG_CONFIG) & 0x7f) | 0x80);
> 	mtp008_write_value(client, MTP008_REG_PIN_CTRL1, save1);
> 	mtp008_write_value(client, MTP008_REG_PIN_CTRL2, save2);
>=20
> 	mtp008_getsensortype(data, save2);

I think I understand that you save some configuration, reset the chip
then restore the configuration? What's the point? Chip reset has proven
to be useless and dangerous for almost all chips. Unless you have a good
reason to do it, don't reset the chip.

> 		for (i =3D 0; i < 3; i++)
> 		{

Wrong curly brace placement.

> MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
> 	      "Philip Edelbrock <phil@netroedge.com>, "

Feel free to drop these. As I understand it, Kris Van Hees wrote the
driver from one Frodo and Philip had written before, but neither Frodo
nor Philip is really the author of this one driver (let alone the port
to 2.6 thereof).

OK, that was only a quick review (still took over an hour, *sigh*), I'll
do a second pass when Helge provides an updated driver for 2.6.14-rc3,
which addresses the points I listed, and implements dynamic sysfs
callbacks.

Thanks,
--
Jean Delvare
