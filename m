From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Jun 2005 23:31:12 +0000
Subject: [lm-sensors] [PATCH 2.6.12-rc5-mm2] max6875: new i2c device driver
Message-Id: <20050623233040.249f4131.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
In-Reply-To: <F06EB2894F3F0D45AD9BEA7246DE9C9076C659@WCSEXCMBS1.ad.wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> This patch adds support for the MAX6875/MAX6874 chips.

Sorry for the long delay. I finally took some time this afternoon to
review your driver. It's a bit late as Greg already pushed it to Linus,
but nevertheless, I'd appreciate it if you could provide an incremental
patch addressing the issues I found.

I also have suggestions for the documentation and the Kconfig help text,
I'll submit patches for that right after.

> #include <linux/sched.h>

I don't think you need this one. eeprom.c has it for capable() but you
don't use it here.

> static int allow_write = 0;

Do not explicitely initialize static variables to 0.

> /* CONFIG EEPROM is at addresses 0x8000 - 0x8045, registers are at 0 - 0x45 */
> #define CONFIG_EEPROM_BASE		0x8000
> #define CONFIG_EEPROM_SIZE		0x0046
> #define CONFIG_EEPROM_SLICES		5

These could conflict with future Linux configuration (Kconfig) settings.
You shouldn't prefix your own defines with CONFIG_.

As a side note, I am not convinced that you have any benefit in using
the slice approach here. It was convenient for the eeprom driver due to
the various use it has and the overall simplicity of the driver, but in
your case it makes the code significantly more complex and the detection
step significantly slower as well. What are the typical accesses to the
interface files in your case?

> #define MAX6875_CMD_BLOCK_WRITE		0x83
> (...)
> #define MAX6875_CMD_REBOOT		0x88

Why define these since you don't use them anywhere?

> 	u8 rdbuf[SLICE_SIZE];

Why do you need this temporary buffer?

> 	    (jiffies - blk->updated[slice] > 300 * HZ) ||
> 	    (jiffies < blk->updated[slice])) {

Please use time_after() like all the other i2c chip drivers now do.

> 				dev_dbg(&client->dev, "max6875 register select has failed!\n");
> (...)
> 				dev_dbg(&client->dev, "max6875 address set has failed!\n");

This should probably be error messages rather than a debug messages.

> 		if (i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_READ_I2C_BLOCK)) {
> 			if (i2c_smbus_read_i2c_block_data(client, MAX6875_CMD_BLOCK_READ,
> 							  rdbuf) != SLICE_SIZE)
> 			{
> 				retval = -1;
> 				goto exit;
> 			}

Misplaced parentheses.

> 				if (j < 0)
> 				{
> 					retval = -1;
> 					goto exit;
> 				}

Misplaced parentheses.

> 				blk->data[(slice << SLICE_BITS) + i] = (u8) j;

The cast is not needed.

>	exit:

Labels should be left aligned.

> static ssize_t max6875_user_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
> {
> 	return max6875_read(kobj, buf, off, count, max6875_eeprom_user);
> }
> 
> static ssize_t max6875_config_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
> {
> 	return max6875_read(kobj, buf, off, count, max6875_eeprom_config);
> }
> 
> static ssize_t max6875_cfgreg_read(struct kobject *kobj, char *buf, loff_t off, size_t count)
> {
> 	return max6875_read(kobj, buf, off, count, max6875_register_config);
> }

Please look into the new callback capabilities introduced recently by
Yani Ioannou. Examples can be found in the adm1026, it87, lm63, lm83 and
lm90 drivers. Basically, this would ley you get rid of these multiple
callback functions, all three files would have the same callback with an
additional argument. Same for the write callbacks, of course. Maybe
you'll have to add some code by yourself if the binary file case isn't
handled yet.

> 	if (down_interruptible(&data->update_lock))
> 		return -EAGAIN;

Aren't you supposed to include <asm/semaphore.h> for this one?

> 		for (sent = 0; sent < count; sent++) {
> 			addr = off + sent;
> 			if (addr = 0x44)
> 				continue;
> 
> 			retval = i2c_smbus_write_byte_data(client, addr, buf[sent]);
> 		}

You should interrupt the loop if retval < 0. With the current code, errors
could easily go unnoticed.

> 			val = (addr & 0xff) | (buf[sent] << 8);	// reversed

No C++-like comments please.

> 			if (addr = 0x8044)
> 				continue;

You could check this earlier.

> 	/* Invalidate the scratch buffer */
> 	for (slice = (off >> SLICE_BITS); slice <= ((off + count - 1) >> SLICE_BITS); slice++)
>		blk->valid &= ~(1 << slice);

Why don't you rather copy the freshly written data to the cache?

> 	error_exit:

Align to left.

> 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_READ_BYTE_DATA |
> 				     I2C_FUNC_SMBUS_BYTE |
>				     I2C_FUNC_SMBUS_WRITE_BYTE_DATA))

The check isnt't complete, as you use i2c_smbus_write_word_data later.
OTOH you don't actually seem to use i2c_smbus_read_byte_data, so why
check for its availability?

I also notice that you didn't implement block write although the chip
appears to support it. This would probably improve the write speed quite
significantly, and I2C_FUNC_SMBUS_WRITE_BLOCK is much more widely
available on bus masters than I2C_FUNC_SMBUS_READ_I2C_BLOCK.

> 	/* OK. For now, we presume we have a valid client. We now create the
> 	   client structure, even though we cannot fill it completely yet.
> 	   But it allows us to access eeprom_{read,write}_value. */

Bogus comment, there is no such functions. BTW the comment is bogus in
the eeprom driver as well, I'll fix it there.

Please add the 24RF08 corruption preventer quirk in your driver (see the
eeprom driver). Every I2C driver in the 0x50-0x5f range should include
it (until I finally rewrite the whole thing).

> 	/* create the sysfs eeprom files with the correct permissions */
> 	if (allow_write = 0) {
> 		user_eeprom_attr.attr.mode &= ~S_IWUGO;
> 		user_eeprom_attr.write = NULL;
> 		config_eeprom_attr.attr.mode &= ~S_IWUGO;
> 		config_eeprom_attr.write = NULL;
> 		config_register_attr.attr.mode &= ~S_IWUGO;
> 		config_register_attr.write = NULL;
> 	}

Sounds like an unsafe approach to me. Why not define the files without
the write permission at first, and add it if and only if allow_write is
non-zero?

> 		dev_err(&client->dev, "Client deregistration failed, client not detached.\n");

Line too long, please split.

That's all as far as the code itself is concerned.

But in fact I am also wondering what the point of this driver is. I'm
not happy with a binary file containing the full set of registers, this
is awfully not convenient to use. Imagine the mess it would be if all
i2c drivers would do the same... Binary files in sysfs are supposed to
be an exception, not the rule.

If this is done this way because you simply flush a blob into the eeprom
once as startup, then a userspace tool relying on i2c-dev would have
been just as efficient, and more flexible.

If OTOH writing individual values to registers happens, then a real
interface to the chip would be much better, with individual files mapping
to individual registers. See how hardware monitoring drivers do. BTW, the
MAX6875 has voltage sensing inputs, so it would somewhat fit in the
hardware monitoring interface layer.

Thanks,
-- 
Jean Delvare
