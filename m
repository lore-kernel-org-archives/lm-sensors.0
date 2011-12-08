From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 17:35:07 +0000
Subject: Re: [lm-sensors] [PATCH] f75375s: added Fintek f75387 support
Message-Id: <1323365707.2415.52.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
In-Reply-To: <CABRa2TKyTHBSZiWMxZZqC2Y=ZZNTQQt_3BXTrt6JzQzj0OsfNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-12-07 at 15:58 -0500, Guenter Roeck wrote:
> Hi Bjoern,
> 
> On Wed, 2011-12-07 at 14:51 -0500, Bjoern Gerhart wrote:
> > Hi Guenter,
> >
> > 2011/12/3 Guenter Roeck <guenter.roeck@ericsson.com>:
> > > Yes, that is much better. Couple of minor comments below.
> > >
> > Thanks   ;-)
> >
> > >>> Configuration register 0x01 and fan register 0x60 are both different. Both are used
> > >>> and needed for fan configuration, so that is definitely a problem that will have
> > >>> to be addressed.
> > >>>
> > >> Ok... so I'll have a look at the difference in the fan related
> > >> registers in order to complete the f75387 implementation.
> > >>
> > > Yes, we'll need that. Fortunately you have your own board, so hopefully you should
> > > be able to play with fan control even if the pins are not connected.
> > >
> > I'm not really sure about how in detail the fan control works and how
> > it is influenced. So just based on the difference in the two chip
> > specs on registers 0x01 and 0x60, I modified  the origin code for
> > implementing it. The resulting patch also including your proposals is
> > attached inline at the end.
> >
> I'll look into the merits tonight or tomorrow. Couple of coding style
> comments below, though.
> 
Hi Bjoern,

couple of additional comments below.

> > Obviously, Harald Dunkel requested the f75387 implementation in 2007.
> > Do you think it would be a good idea to contact him asking for a fan
> > test on his board..?
> >
> Definitely. Worst case he does not reply or no longer has the hardware.
> 
> > --
> > Bjoern Gerhart
> >
> >
> >
> > diff -uNr linux-2.6.39-orig/drivers/hwmon/f75375s.c
> > linux-2.6.39/drivers/hwmon/f75375s.c
> > --- linux-2.6.39-orig/drivers/hwmon/f75375s.c 2011-12-02
> > 14:41:16.000000000 +0100
> 
> Somewhere your patch got line wrapped and thus corrupted, making it
> quite difficult to work with.
> 
> > +++ linux-2.6.39/drivers/hwmon/f75375s.c      2011-12-06 14:33:49.000000000 +0100
> > @@ -1,6 +1,6 @@
> > /*
> > - * f75375s.c - driver for the Fintek F75375/SP and F75373
> > - *             hardware monitoring features
> > + * f75375s.c - driver for the Fintek F75375/SP, F75373 and
> > + *             F75387SG/RG hardware monitoring features
> >  * Copyright (C) 2006-2007  Riku Voipio
> >  *
> >  * Datasheets available at:
> > @@ -10,6 +10,9 @@
> >  *
> >  * f75373:
> >  * http://www.fintek.com.tw/files/productfiles/F75373_V025P.pdf
> > + *
> > + * f75387:
> > + * http://www.fintek.com.tw/files/productfiles/F75387_V027P.pdf
> >  *
> >  * This program is free software; you can redistribute it and/or modify
> >  * it under the terms of the GNU General Public License as published by
> > @@ -40,7 +43,7 @@
> > /* Addresses to scan */
> > static const unsigned short normal_i2c[] = { 0x2d, 0x2e, I2C_CLIENT_END };
> >
> > -enum chips { f75373, f75375 };
> > +enum chips { f75373, f75375, f75387 };
> >
> > /* Fintek F75375 registers  */
> > #define F75375_REG_CONFIG0            0x0
> > @@ -59,6 +62,7 @@
> > #define F75375_REG_VOLT_LOW(nr)               (0x21 + (nr) * 2)
> >
> > #define F75375_REG_TEMP(nr)           (0x14 + (nr))
> > +#define F75387_REG_TEMP11_LSB(nr)    (0x1a + (nr))
> > #define F75375_REG_TEMP_HIGH(nr)      (0x28 + (nr) * 2)
> > #define F75375_REG_TEMP_HYST(nr)      (0x29 + (nr) * 2)
> >
> > @@ -78,8 +82,11 @@
> > #define F75375_REG_PWM1_DROP_DUTY     0x6B
> > #define F75375_REG_PWM2_DROP_DUTY     0x6C
> >
> > -#define FAN_CTRL_LINEAR(nr)          (4 + nr)
> > +#define F75375_FAN_CTRL_LINEAR(nr)   (4 + nr)
> > +#define F75387_FAN_CTRL_LINEAR(nr)   (1 + ((nr) * 4))
> > #define FAN_CTRL_MODE(nr)             (4 + ((nr) * 2))
> > +#define F75387_FAN_DUTY_MODE(nr)     (2 + ((nr) * 4))
> > +#define F75387_FAN_MANU_MODE(nr)     ((nr) * 4)
> >
> > /*
> >  * Data structures and manipulation thereof
> > @@ -108,7 +115,12 @@
> >       u8 pwm[2];
> >       u8 pwm_mode[2];
> >       u8 pwm_enable[2];
> > -     s8 temp[2];
> > +     /*
> > +      * f75387: For remote temperature reading, it uses signed 11-bit
> > +      * values with LSB = 0.125 degree Celsius, left-justified in 16-bit
> > +      * registers. For original 8-bit temp readings, the LSB just is 0.
> > +      */
> > +     s16 temp11[2];
> >       s8 temp_high[2];
> >       s8 temp_max_hyst[2];
> > };
> > @@ -122,6 +134,7 @@
> > static const struct i2c_device_id f75375_id[] = {
> >       { "f75373", f75373 },
> >       { "f75375", f75375 },
> > +     { "f75387", f75387 },
> >       { }
> > };
> > MODULE_DEVICE_TABLE(i2c, f75375_id);
> > @@ -205,8 +218,13 @@
> >       if (time_after(jiffies, data->last_updated + 2 * HZ)
> >               || !data->valid) {
> >               for (nr = 0; nr < 2; nr++) {
> > -                     data->temp[nr] > > -                             f75375_read8(client, F75375_REG_TEMP(nr));
> > +                     /* assign MSB, therefore shift it by 8 bits */
> > +                     data->temp11[nr] > > +                             f75375_read8(client, F75375_REG_TEMP(nr)) << 8;
> > +                     if (data->kind = f75387)
> > +                             /* merge F75387's temperature LSB (11-bit) */
> > +                             data->temp11[nr] |> > +                                     f75375_read8(client, F75387_REG_TEMP11_LSB(nr));
> >                       data->fan[nr] > >                               f75375_read16(client, F75375_REG_FAN(nr));
> >               }
> > @@ -298,24 +316,44 @@
> >               return -EINVAL;
> >
> >       fanmode = f75375_read8(client, F75375_REG_FAN_TIMER);
> > -     fanmode &= ~(3 << FAN_CTRL_MODE(nr));
> > +     if (data->kind != f75387)
> > +             fanmode &= ~(3 << FAN_CTRL_MODE(nr));
> >
> I'll have to look into this - it is a bit suspicious that you would not
> need a mask for F75387.
> 
The point of the original code is that the fanX_mode bits are cleared
for the current fan, preparing the value for speed mode (which is why
nothing changes below for val=3, speed mode). For F75387, you'll want
to clear the relevant bits as well.

    if (data->kind = f75387) {
	fanmode &= ~(1 << F75387_FAN_DUTY_MODE(nr));
	fanmode &= ~(1 << F75387_FAN_MANU_MODE(nr));
    } else {
	fanmode &= ~(3 << FAN_CTRL_MODE(nr));
    }

> >       switch (val) {
> > -     case 0: /* Full speed */
> > -             fanmode  |= (3 << FAN_CTRL_MODE(nr));
> > -             data->pwm[nr] = 255;
> > -             f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
> > -                             data->pwm[nr]);
> > -             break;
> > -     case 1: /* PWM */
> > -             fanmode  |= (3 << FAN_CTRL_MODE(nr));
> > -             break;
> > -     case 2: /* AUTOMATIC*/
> > -             fanmode  |= (2 << FAN_CTRL_MODE(nr));
> > -             break;
> > -     case 3: /* fan speed */
> > -             break;
> > +             case 0: /* Full speed */
> 
> Documentation/CodingStyle, chapter 1, indentation:
> 'align the "switch" and its subordinate "case" labels in the same
> column'
> 
> While this is not mandatory, but just "the preferred way", there is no
> reason to change it to something else in existing code.
> 
> > +                     if (data->kind = f75387) {
> > +                             /* manual mode, follow expected RPM */
> > +                             fanmode  |=  (1 << F75387_FAN_MANU_MODE(nr));
> > +                             fanmode  &= ~(1 << F75387_FAN_DUTY_MODE(nr));

Wrong, since we never set the expected rpm registers. Needs to follow
pwm; otherwise setting the pwm register to 255 later on would not help.

			  fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));


> > +                     } else
> > +                             fanmode  |= (3 << FAN_CTRL_MODE(nr));
> > +
> 
> Chapter 3, Placing Braces and Spaces:
> 
> Either use no braces, or use braces in both branches of an if statement.
> 
> > +                     data->pwm[nr] = 255;
> > +                     f75375_write8(client, F75375_REG_FAN_PWM_DUTY(nr),
> > +                                     data->pwm[nr]);
> > +                     break;
> > +             case 1: /* PWM */
> > +                     if (data->kind = f75387) {
> > +                             /* manual mode, follow expected PWM duty */
> > +                             fanmode  |= (1 << F75387_FAN_MANU_MODE(nr));
> > +                             fanmode  |= (1 << F75387_FAN_DUTY_MODE(nr));
> > +                     } else
> > +                             fanmode  |= (3 << FAN_CTRL_MODE(nr));
> > +
> > +                     break;
> > +             case 2: /* AUTOMATIC*/
> > +                     if (data->kind = f75387) {
> > +                             /* automatic mode, follow expected PWM duty */
> > +                             fanmode  &= ~(1 << F75387_FAN_MANU_MODE(nr));

Already reset above, so no need to clear it here.

> > +                             fanmode  |=  (1 << F75387_FAN_DUTY_MODE(nr));
> > +                     } else
> > +                             fanmode  |= (2 << FAN_CTRL_MODE(nr));
> > +
> > +                     break;
> > +             case 3: /* fan speed */

To follow fan speed, we'll have to set manual mode for F75387.

		if (data->kind = f75387)
			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));

> > +                     break;
> >       }
> > +

Actually, thinking about this function, it might be simpler to change it
to check for data->kind first, and then have two separate case
statements to determine fanmode. Something along the line of:

	if (data->kind = f75387) {
		fanmode &= ~(1 << F75387_FAN_DUTY_MODE(nr));
		fanmode &= ~(1 << F75387_FAN_MANU_MODE(nr));
		switch (val) {
		case 0: /* full speed */
			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
			data->pwm[nr] = 255;
			f75375_write8(client,
					F75375_REG_FAN_PWM_DUTY(nr),
					data->pwm[nr]);
			break;

		case 1: /* PWM */
			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
			fanmode |= (1 << F75387_FAN_DUTY_MODE(nr));
			break;
		case 2: /* AUTOMATIC*/
			fanmode |=  (1 << F75387_FAN_DUTY_MODE(nr));
			break;
		case 3: /* fan speed */
			fanmode |= (1 << F75387_FAN_MANU_MODE(nr));
			break;
		}
	} else {
		fanmode &= ~(3 << FAN_CTRL_MODE(nr));
		switch (val) {
		case 0: /* full speed */
			fanmode |= (3 << FAN_CTRL_MODE(nr));
			data->pwm[nr] = 255;
			f75375_write8(client,
					F75375_REG_FAN_PWM_DUTY(nr),
					data->pwm[nr]);
			break;
		case 1: /* PWM */
			fanmode |= (3 << FAN_CTRL_MODE(nr));
			break;
		case 2: /* AUTOMATIC*/
			fanmode |= (2 << FAN_CTRL_MODE(nr));
			break;
		case 3: /* fan speed */
			break;
		}
	}

On a side note, the valid range of <val> is <0..4>. No idea what 4 is
supposed to be used for. I suspect it is a bug and should be <0..3>.
Separate patch, though.

We should also have a fanX_target attribute to be able to set the target
speed (registers 0x84 and 0x85) for all chips (so that setting pwmX_mode
to 3 would actually make sense), but that would be yet another patch.

> >       f75375_write8(client, F75375_REG_FAN_TIMER, fanmode);
> >       data->pwm_enable[nr] = val;
> >       return 0;
> > @@ -344,18 +382,28 @@
> >       struct f75375_data *data = i2c_get_clientdata(client);
> >       int val = simple_strtoul(buf, NULL, 10);
> >       u8 conf = 0;
> > +     char reg;
> > +     char ctrl;
> >
> >       if (!(val = 0 || val = 1))
> >               return -EINVAL;
> >
> > +     if (data->kind = f75387) {
> > +             reg = F75375_REG_FAN_TIMER;
> > +             ctrl = F75387_FAN_CTRL_LINEAR(nr);
> > +     } else {
> > +                reg = F75375_REG_CONFIG1;
> > +             ctrl = F75375_FAN_CTRL_LINEAR(nr);
> 
> Indentation doesn't look right here.
> 
> > +     }
> > +
> >       mutex_lock(&data->update_lock);
> > -     conf = f75375_read8(client, F75375_REG_CONFIG1);
> > -     conf &= ~(1 << FAN_CTRL_LINEAR(nr));
> > +     conf = f75375_read8(client, reg);
> > +     conf &= ~(1 << ctrl);
> >
> >       if (val = 0)
> > -             conf |= (1 << FAN_CTRL_LINEAR(nr)) ;
> > +             conf |= (1 << ctrl) ;
> 
> Please remove the extra space since we are at it ...
> 
> >
> > -     f75375_write8(client, F75375_REG_CONFIG1, conf);
> > +     f75375_write8(client, reg, conf);
> >       data->pwm_mode[nr] = val;

Oddly enough, the code never sets pwm_mode[] except here, which means it
is always displayed as 0 (DC) unless it is changed explicitly. And
DC/Linear mode isn't even supported on F75373.

The code also doesn't initialize pwm_enable unless it is (re-)configured
through platform_data, which means reading pwmX_enable will also return
0 until overwritten unless there is platform data.

Yet another set of patches to fix that...

> >       mutex_unlock(&data->update_lock);
> >       return count;
> > @@ -435,13 +483,14 @@
> > }
> > #define TEMP_FROM_REG(val) ((val) * 1000)
> > #define TEMP_TO_REG(val) ((val) / 1000)
> > +#define TEMP11_FROM_REG(reg) ((reg) / 32 * 125)
> >
> > -static ssize_t show_temp(struct device *dev, struct device_attribute *attr,
> > +static ssize_t show_temp11(struct device *dev, struct device_attribute *attr,
> >               char *buf)
> > {
> >       int nr = to_sensor_dev_attr(attr)->index;
> >       struct f75375_data *data = f75375_update_device(dev);
> > -     return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp[nr]));
> > +     return sprintf(buf, "%d\n", TEMP11_FROM_REG(data->temp11[nr]));
> > }
> >
> > static ssize_t show_temp_max(struct device *dev, struct device_attribute *attr,
> > @@ -525,12 +574,12 @@
> >       show_in_max, set_in_max, 3);
> > static SENSOR_DEVICE_ATTR(in3_min, S_IRUGO|S_IWUSR,
> >       show_in_min, set_in_min, 3);
> > -static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp, NULL, 0);
> > +static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_temp11, NULL, 0);
> > static SENSOR_DEVICE_ATTR(temp1_max_hyst, S_IRUGO|S_IWUSR,
> >       show_temp_max_hyst, set_temp_max_hyst, 0);
> > static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO|S_IWUSR,
> >       show_temp_max, set_temp_max, 0);
> > -static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp, NULL, 1);
> > +static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_temp11, NULL, 1);
> > static SENSOR_DEVICE_ATTR(temp2_max_hyst, S_IRUGO|S_IWUSR,
> >       show_temp_max_hyst, set_temp_max_hyst, 1);
> > static SENSOR_DEVICE_ATTR(temp2_max, S_IRUGO|S_IWUSR,
> > @@ -685,10 +734,15 @@
> >
> >       vendid = f75375_read16(client, F75375_REG_VENDOR);
> >       chipid = f75375_read16(client, F75375_CHIP_ID);
> > -     if (chipid = 0x0306 && vendid = 0x1934)
> > +     if (vendid != 0x1934)
> > +             return -ENODEV;
> > +
> > +     if (chipid = 0x0306)
> >               name = "f75375";
> > -     else if (chipid = 0x0204 && vendid = 0x1934)
> > +     else if (chipid = 0x0204)
> >               name = "f75373";
> > +     else if (chipid = 0x0410)
> > +             name = "f75387";
> >       else
> >               return -ENODEV;
> >
> > @@ -711,7 +765,7 @@
> >
> > MODULE_AUTHOR("Riku Voipio");
> > MODULE_LICENSE("GPL");
> > -MODULE_DESCRIPTION("F75373/F75375 hardware monitoring driver");
> > +MODULE_DESCRIPTION("F75373/F75375/F75387 hardware monitoring driver");
> >
> > module_init(sensors_f75375_init);
> > module_exit(sensors_f75375_exit);
> > diff -uNr linux-2.6.39-orig/drivers/hwmon/Kconfig
> > linux-2.6.39/drivers/hwmon/Kconfig
> > --- linux-2.6.39-orig/drivers/hwmon/Kconfig   2011-12-02 14:41:28.000000000 +0100
> > +++ linux-2.6.39/drivers/hwmon/Kconfig        2011-12-02 13:21:46.000000000 +0100
> > @@ -335,11 +335,11 @@
> >         will be called f71882fg.
> >
> > config SENSORS_F75375S
> > -     tristate "Fintek F75375S/SP and F75373"
> > +     tristate "Fintek F75375S/SP, F75373 and F75387"
> >       depends on I2C
> >       help
> >         If you say yes here you get support for hardware monitoring
> > -       features of the Fintek F75375S/SP and F75373
> > +       features of the Fintek F75375S/SP, F75373 and F75387
> >
> >         This driver can also be built as a module.  If so, the module
> >         will be called f75375s.
> 
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
