From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: ADM1031 Driver
Message-Id: <1082455107.4084f4437e1e4@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
In-Reply-To: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here is the new version of the ADM1030/ADM1031 driver.
> 
> It does not support auto fan control yet.

Well, I see some parts of it already. I would suggest that you include
it completely or not at all.

> I have modified the driver to be more inline with lm85 one. Hope
> that version will satisfy Jean :)

You will learn the hard way that I am never satisfied ;)

>     Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
>     Copyright (c) 2004 Alexandre d'Alton <alex@alexdalton.org>

Copyright is (C) not (c). I wouldn't even mention Frodo's name here
(there is *nothing* from his original code in your file). You already
point to the files you took your inspiration from and which will be
distributed together with yours, it should be enough. If you really
want to include Frodo's name, please do *not* include his e-mail
address. He forwards i2c-related e-mails to the sensors mailing-list,
so it's a waste of time for him, and the users, and us. 

> #define ADM1031_REG_FAN_SPEED(nr)   	(0x08 + (nr))
> 
> #define ADM1031_REG_FAN_DIV(nr)		(0x20  + (nr))
> #define ADM1031_REG_PWM(nr)		(0x22)
> #define ADM1031_REG_FAN_MIN(nr)		(0x10 + (nr))

I would appreciate a comment stating that nr starts with 0 in all
theses
macros.

> #define ADM1031_REG_CONF(nr)                        (nr)

I don't see much benefit in making this a "function". This doesn't
enable any code refactoring.

> struct adm1031_data {
>   struct semaphore	update_lock;
>   int                   chip_type;
>   char			valid;		/* !=0 if following fields are valid */
>   unsigned int		last_updated;	/* In jiffies */
>   unsigned int		conf;
>   unsigned int		fan[2];
>   unsigned int	       	fan_div[2];
>   unsigned int	       	fan_min[2];
>   unsigned int	       	pwm[2];
>   unsigned int          temp[3];
>   unsigned int          auto_temp[3];
>   unsigned int          temp_min[3];
>   unsigned int          temp_max[3];
>   unsigned int          temp_crit[3];
> };

All registers are really u8, which spares much place.

> #define TEMP_TO_REG(val)   ((val) / 1000)

(((val) + 500) / 10000) for better rounding.

> #define FAN_FROM_REG(reg, div) ((reg) ? (11250 * 60) / ((reg) *
> (div)) : 0)
> #define FAN_TO_REG(reg, div) FAN_FROM_REG(reg, div)

No, both conversions are not exacly the same. For valid values they
are,
but not for limit cases. REF=0xFF means fan is stopped, so FAN must
read 0. REF=0x00 is theoretically impossible is usually reported as
FAN=-1. For the other way around, setting fan min to 0 means writting
0xFF to the register. See w83627hf.c for a good example of how to do
that.

> #define FAN_DIV_TO_REG(val) val = 8 ? 0xc0 :  \
> 	    val = 4 ? 0x80 :                  \
> 	    val = 2 ? 0x40 :                  \
> 	    val = 1 ? 0x00 : 0x00

That's not quite correct. You don't want to default to an arbitrary
value if the request isn't valid. Instead you want to leave the old
value untouched and return an error (-EINVAL). See fscher.c for a nice
example.

> #define PWM_TO_REG(val) (val)

You don't check limits. What if the user tries to set this to -42 or
1000?

> #define PWM_FROM_REG(val) (val)

That one is very useful ;)

> show_fan_offset(1);
> show_fan_offset(2);

You should change that name, since the macros expand to both show and
set functions. Ditto for pwm and temperatures

> 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_WORD_DATA))

I don't see any word operation in your code.

> 	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
> 				   sizeof(struct adm1031_data),
> 				   GFP_KERNEL))) {
> 		err = -ENOMEM;
> 		goto exit;
> 	}

This memory allocation scheme has been deprecated (causes problems on
non-x86 achitectures). Please take a look at any driver (except w83781d
and asb100) in kernel 2.6.6-rc1 for the correct way to allocate memory.
Basically you need to include a "client" member in the private data
structure and allocate just this private structure (so we still have a
single allocation for everything, but this time the compiler takes care
of alignement tricks).

> 	if (kind = adm1030) {
> 		name = "adm1030";
> 	}

+ else

> 	if (kind = adm1031) {
> 		name = "adm1031";
> 	}

> static int adm1031_read_value(struct i2c_client *client, u8 reg)
> {
>   return i2c_smbus_read_byte_data(client, reg);
> }
> 
> static int adm1031_write_value(struct i2c_client *client, u8 reg,
> unsigned int value)
> {
>     return i2c_smbus_write_byte_data(client, reg, value);
> }

Inline these.

> 		data->fan_div[0]   = 
> 		  adm1031_read_value(client,
> 				     ADM1031_REG_FAN_DIV(0)); 
> 		data->fan[0] > 		  adm1031_read_value(client,
> 				     ADM1031_REG_FAN_SPEED(0));
> 		data->pwm[0]       = 0xf &
> 		    adm1031_read_value(client, ADM1031_REG_PWM(0));

Doesn't the ADM1031 have a second fan?

Aha, I told you I was never satisfied ;) But thanks to this your code is
improving each time and will be more robust and easier to maintain.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
