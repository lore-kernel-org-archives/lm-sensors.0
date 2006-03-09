From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Mar 2006 17:46:05 +0000
Subject: [lm-sensors] New 2.6 kernel patch for hardware monitoring
Message-Id: <20060309184605.08aad1c1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603042101570.3972@Laila>
In-Reply-To: <Pine.LNX.4.63.0603042101570.3972@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

Sorry for the late answer...

> Attached is a new attempt at a kernel patch with SMSC 47M192 driver.
> 
> New features:
> * patch is now relative to 2.6.16-rc5 (I had to change the driver
>     definition in order to make it work - hope this is correct?)

Yes it is alright. The only thing left for merging in -mm will be to
change from semaphore to mutex, but this can be done anytime later.

> * initialize alarm limits if monitoring is not running at the time of
>     loading the driver

Looks all OK too.

> * don't create in4_* files in /sys if 12V input pin is used for VID4

Good, I didn't even notice that it was missing from the first version
of your driver.

> * proper assignment of temperature offsets to temp* channels

Doesn't seem totally correct to me yet. Looking at the following part of
smsc47m192_update_device():

> 		data->temp_offset[2] = i2c_smbus_read_byte_data(client,
> 						SMSC47M192_REG_TEMP_OFFSET(3));
> 		for (i = 1; i < 3; i++)
> 			data->temp_offset[i] = i2c_smbus_read_byte_data(client,
> 						SMSC47M192_REG_TEMP_OFFSET(i));

This is setting the value of data->temp_offset[2] twice; obviously not
what you wanted. I guess that the first instruction is a leftover from
your previous code? At any rate, there are only two offset registers, so
you want exactly two register reads.

> * create individual files for all alarms (temp*_alarm, temp*_fault,
>     in*_alarm). I've still kept the bit patterns alarms_temp etc for now,
>     so there is redundant information.

OK, fair enough, this has the added benefit that we can compare both
approaches (even if not from a driver size point of view, we'd need two
separate patches for that.) However, when finally merging the driver,
we'll have to choose one way and discard the other - redundancy makes
the driver larger, increases the risk of bugs, and has overall no
interest.

> * add definition of individual alarm files to sysfs-interface
>     documentation

I have a separate patch doing this in a more detailed way:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-sysfs-interface-individual-alarm-files.patch

So please discard that part from your own patch. You can keep
temp[1-4]_offset and faults_temp (at least for now) though.

> * add cross references into kernel configuration help texts for
>     smsc47m192 and smsc47m1 drivers

Very good, hopefully this will help the users pick the right driver.

> * add smsc47m192 driver documentation

Thanks for that, this is very welcome. A large part of the "/sys files"
section (which would be better named "sysfs interface" IMHO) is
redundant with Dcumentation/hwmon/sysfs-interface, so you may want to
skip everything which isn't driver specific. But I don't care that much
either, the interface isn't supposed to change anyway so this won't
increase the maintenance workload.

A few random comments on this new patch:

> --- linux-2.6.16-rc5/Documentation/hwmon/smsc47m192	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-new/Documentation/hwmon/smsc47m192	2006-03-04 22:00:17.000000000 +0100
> (...)
> +in_[0-7]_alarm	- alarm flags for voltage inputs

in[0-7]_alarm

> --- linux-2.6.16-rc5/drivers/hwmon/smsc47m192.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.16-new/drivers/hwmon/smsc47m192.c	2006-03-04 22:31:30.000000000 +0100
> (...)
> +/* SMSC47M192 registers */
> +#define SMSC47M192_REG_IN_MAX(nr)	(0x2b + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
> +#define SMSC47M192_REG_IN_MIN(nr)	(0x2c + (nr) * 2 + ((nr)>5 ? 0x1d : 0))
> +#define SMSC47M192_REG_IN(nr)		(0x20 + (nr) + ((nr)>5 ? 0x2a : 0))
> +
> +#define SMSC47M192_REG_TEMP(nr)		(0x27 - (nr) + ((nr)>1 ? 0x2d : 0))
> +#define SMSC47M192_REG_TEMP_MAX(nr)	(0x39 - (nr) * 2 + ((nr)>1 ? 0x23 : 0))
> +#define SMSC47M192_REG_TEMP_MIN(nr)	(0x3a - (nr) * 2 + ((nr)>1 ? 0x23 : 0))
> +#define SMSC47M192_REG_TEMP_OFFSET(nr)	(0x1f - ((nr)>1 ? 1 : 0))

These definitions are really not easy to check against the datasheet. I
invite you to consider what Yuan and Rudolf did in the w83627ehf driver
for the voltage macros:

#define W83627EHF_REG_IN_MAX(nr)	((nr < 7) ? (0x2b + (nr) * 2) : \
					 (0x554 + (((nr) - 7) * 2)))
#define W83627EHF_REG_IN_MIN(nr)	((nr < 7) ? (0x2c + (nr) * 2) : \
					 (0x555 + (((nr) - 7) * 2)))
#define W83627EHF_REG_IN(nr)		((nr < 7) ? (0x20 + (nr)) : \
					 (0x550 + (nr) - 7))

As for temperatures, I'd suggest something along the lines of what was
done in the lm87 driver:

static u8 LM87_REG_TEMP[3] = { 0x27, 0x26, 0x20 };
static u8 LM87_REG_TEMP_HIGH[3] = { 0x39, 0x37, 0x2B };
static u8 LM87_REG_TEMP_LOW[3] = { 0x3A, 0x38, 0x2C };

If you don't want to do the same for SMSC47M192_REG_TEMP_OFFSET, please
at least simplify its definition to:

#define SMSC47M192_REG_TEMP_OFFSET(nr)	((nr)>1 ? 0x1e : 0x1f)

Here again, the idea is to make is as easy as possible to check against
the datasheet.

> +show_in_offset(0);
> +show_in_offset(1);
> +show_in_offset(2);
> +show_in_offset(3);
> +show_in_offset(4);
> +show_in_offset(5);
> +show_in_offset(6);
> +show_in_offset(7);
> (...)
> +show_temp_index(1);
> +show_temp_index(2);
> +show_temp_index(3);

The trailing semi-colon is redundant (but otherwise harmless, granted.)

> +		if (	i2c_smbus_read_byte_data(client,
> +					SMSC47M192_REG_COMPANY_ID) = 0x55
> +			&& ((version = i2c_smbus_read_byte_data(client,
> +					SMSC47M192_REG_VERSION)) & 0xf0) = 0x20
> +			&& (i2c_smbus_read_byte_data(client,
> +					SMSC47M192_REG_VID) & 0x70) = 0x00
> +			&& (i2c_smbus_read_byte_data(client,
> +					SMSC47M192_REG_VID4) & 0xfe) = 0x80) {

I'm still not convinced by your indentation here. You aren't supposed
to have a tab after an opening parenthesis.

> +			dev_info(&adapter->dev,
> +					"found SMSC47M192 or SMSC47M997, "
> +						"version 2, stepping A%d\n",
> +						version&0x0f);

I'm sure you can get this to fit on 3 lines max ;) Also, how relevant is
it to mention "version 2" given that all chips have this same version
by definition (else they are not supported by the driver)?

> +			dev_dbg(&adapter->dev,
> +				"SMSC47M192 detection failed at 0x%02x.\n",
> +								address);

Please drop the trailing dot.

> +static void smsc47m192_init_client(struct i2c_client *client)
> (...)
> +	if (!(config & 0x01)) {
> (...)
> +		/* select cycle mode (pause 1 sec between updates) */
> +		i2c_smbus_write_byte_data(client, SMSC47M192_REG_SFR,
> +						(sfr & 0xfd) | 0x02);

Switching the chip to cycle mode should always be done if needed, even
if monitoring is already started, shouldn't it? Also, please group the
SFR register read and the write-back (this is a good practice when doing
read-modify-write operations.)

> +	}
> +
> +}

Extra blank line not needed, please remove.

> +static struct smsc47m192_data *smsc47m192_update_device(struct device *dev)
> (...)
> +		config = i2c_smbus_read_byte_data(client,SMSC47M192_REG_CONFIG);

Missing space after comma.

> +		data->alarm[0] = (alarms & 0x000f) + ((alarms & 0x0f00) >> 4);
> +		data->alarm[1] = (alarms & 0x0070) >> 4;
> +		data->alarm[2] = (alarms >> 13) & 6;

As a side note for the new standard interface discussion, this is less
complex than I would have first thought. However, this is still tricky,
not trivial to validate code, and some other chips (e.g. Winbond ones)
may need much more complex computations.

More on that later.

Anyway, I'm really happy with your code now, Hartmut. My comments above
are really details now. If you can provide a new patch addressing these
minor issues, I'll be happy to consider merging it (except for the
redundant alarm interface). I'll need you to add a "Signed-off-by" line
though, and please also add a small text explaining what the patch does
(this will be used as the commit message in git.)

Thanks a lot for your good work.
-- 
Jean Delvare

