From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 12 Oct 2011 15:41:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <1318434083.2454.29.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-10-12 at 11:25 -0400, Jonathan Cameron wrote:
> On 10/12/11 16:19, Guenter Roeck wrote:
> > On Wed, 2011-10-12 at 05:36 -0400, michael.hennerich@analog.com wrote:
> >> From: Michael Hennerich <michael.hennerich@analog.com>
> >>
> >> The Analog Devices ADT75 has an additional register at 0x04
> >> for initiating oneshot captures. It is not actively used in
> >> this driver but we must avoid assuming it will behave as
> >> 0x05-0x07 do and return the last read value. In fact register 0x04
> >> reads the same as register 0x00. And all registers are repetitive
> >> mirrored around register 0x04. This fact is used to detect the ADT75.
> >>
> >> This patch is based on an reworked proposal from Jonathan Cameron <jic23@cam.ac.uk>
> >>
> >> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> >> ---
> >>  Documentation/hwmon/lm75 |    5 +++++
> >>  drivers/hwmon/Kconfig    |    1 +
> >>  drivers/hwmon/lm75.c     |   30 ++++++++++++++++++++++++++----
> >>  3 files changed, 32 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/hwmon/lm75 b/Documentation/hwmon/lm75
> >> index a179040..8d40d0f 100644
> >> --- a/Documentation/hwmon/lm75
> >> +++ b/Documentation/hwmon/lm75
> >> @@ -32,6 +32,11 @@ Supported chips:
> >>      Addresses scanned: I2C 0x48 - 0x4f
> >>      Datasheet: Publicly available at the Microchip website
> >>                 http://www.microchip.com/
> >> +  * Analog Devices ADT75
> >> +    Prefix: 'adt75'
> >> +    Addresses scanned: I2C 0x48 - 0x4f
> >> +    Datasheet: Publicly available at the Analog Devices website
> >> +               http://www.analog.com/adt75
> >>  
> >>  Author: Frodo Looijaard <frodol@dds.nl>
> >>  
> >> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> >> index 0b62c3c..497fd14 100644
> >> --- a/drivers/hwmon/Kconfig
> >> +++ b/drivers/hwmon/Kconfig
> >> @@ -531,6 +531,7 @@ config SENSORS_LM75
> >>  	  If you say yes here you get support for one common type of
> >>  	  temperature sensor chip, with models including:
> >>  
> >> +		- Analog Devices ADT75
> >>  		- Dallas Semiconductor DS75 and DS1775
> >>  		- Maxim MAX6625 and MAX6626
> >>  		- Microchip MCP980x
> >> diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
> >> index ef902d5..0f0291c 100644
> >> --- a/drivers/hwmon/lm75.c
> >> +++ b/drivers/hwmon/lm75.c
> >> @@ -35,6 +35,7 @@
> >>   */
> >>  
> >>  enum lm75_type {		/* keep sorted in alphabetical order */
> >> +	adt75,
> >>  	ds1775,
> >>  	ds75,
> >>  	lm75,
> >> @@ -213,6 +214,7 @@ static int lm75_remove(struct i2c_client *client)
> >>  }
> >>  
> >>  static const struct i2c_device_id lm75_ids[] = {
> >> +	{ "adt75", adt75, },
> >>  	{ "ds1775", ds1775, },
> >>  	{ "ds75", ds75, },
> >>  	{ "lm75", lm75, },
> >> @@ -241,7 +243,7 @@ static int lm75_detect(struct i2c_client *new_client,
> >>  	struct i2c_adapter *adapter = new_client->adapter;
> >>  	int i;
> >>  	int conf, hyst, os;
> >> -	bool is_lm75a = 0;
> >> +	bool is_lm75a = 0, is_adt75 = 0;
> >>  
> >>  	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> >>  				     I2C_FUNC_SMBUS_WORD_DATA))
> >> @@ -259,7 +261,15 @@ static int lm75_detect(struct i2c_client *new_client,
> >>  	   LM75s.  It has an ID byte of 0xaX (where X is the chip
> >>  	   revision, with 1 being the only revision in existence) in
> >>  	   register 7, and unused registers return 0xff rather than the
> >> -	   last read value. */
> >> +	   last read value.
> >> +
> >> +	   The Analog Devices ADT75 has an additional register at 0x04
> >> +	   for initiating oneshot captures. It is not actively used in
> >> +	   this driver but we must avoid assuming it will behave as
> >> +	   0x05-0x07 do and return the last read value. In fact register 0x04
> >> +	   reads the same as register 0x00. And all registers are repetitive
> >> +	   mirrored around register 0x04.
> >> +	*/
> >>  
> >>  	/* Unused bits */
> >>  	conf = i2c_smbus_read_byte_data(new_client, 1);
> >> @@ -277,7 +287,16 @@ static int lm75_detect(struct i2c_client *new_client,
> >>  		is_lm75a = 1;
> >>  		hyst = i2c_smbus_read_byte_data(new_client, 2);
> >>  		os = i2c_smbus_read_byte_data(new_client, 3);
> >> -	} else { /* Traditional style LM75 detection */
> >> +	} else { /* ADT75 detection: mirrored registers */
> >> +		os = i2c_smbus_read_byte_data(new_client, 3);
> >> +		hyst = i2c_smbus_read_byte_data(new_client, 2);
> >> +		if (i2c_smbus_read_byte_data(new_client, 7) = os
> >> +		 || i2c_smbus_read_byte_data(new_client, 11) = os
> >> +		 || i2c_smbus_read_byte_data(new_client, 15) = os)
> >> +			is_adt75 = 1;
> > 
> > This seems to be quite weak. It assumes the chip is ADT75 if any of
> > registers {7, 11, 15} matches register 3. We already know that on a
> > regular LM75, register 11 will match register 3, because the address
> > cycling code checks for it. So it seems to me that the code here will
> > always conclude that the chip is an ADT75.
> Dratt, I read that as a load of ands which I guess is the intent.
> 
Yes, that would make more sense. To improve detection quality, it might
even make sense to additionally check {6, 10, 14} against hyst. Or maybe
check {7, 15} against os and {6, 14} against hyst, since the address
cycling code will already cover registers 10 and 11.

Having said that, turns out we use a LM75 in one of out systems which
returns 0xff in registers 4..7. That won't work with the regular LM75
detection either. Interesting. I'll try to find out the manufacturer.
Here is the register dump, in case Jean listens in and would like to
have a copy.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
10: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
20: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
30: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
40: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
50: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
60: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
70: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
80: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
90: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
a0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
b0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
c0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
d0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
e0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....
f0: 15 00 4b 50 ff ff ff ff 15 00 4b 50 ff ff ff ff    ?.KP....?.KP....

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
