From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: New driver for MAX663x temperature sensor.
Message-Id: <20040412192835.134f0d33.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1081775028.11592.294.camel@uganda>
In-Reply-To: <1081775028.11592.294.camel@uganda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Either go and see with Marcelo directly (good luck) or submit your
> > driver as a patch against our CVS lm_sensors2 repository.
> 
> Will do when all technical questions will be resolved.
> I don't think sending it to Marcelo has any sense.

Agreed.

> > First of all: which MAX663x chips is the driver for? MAX6629-MAX6632
> > are non-I2C chips according to Maxim-IC, so I guess it's
> > MAX6633-MAX6635?
> 
> MAX663x = any max663*. Maxim-IC produces only MAX6633-MAX6635 devices
> matching this regexp.

You did not read me carefully. There's a MAX6629-MAX6632 family:
http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2577/ln/en
Same kind of chips, different interface.

Which is why I think it's important to clearly state which chips you are
supporting, like you did.

> > > + * The GNU GPL is contained in /usr/doc/copyright/GPL on a Debian
> > > + * system and in the file COPYING in the Linux kernel source.
> > 
> > This doesn't belong to kernel code IMHO.
> 
> It does.

Let me rephrase then. The kernel code is kernel code ;) It doesn't
depend on a distribution.

The usual GPL disclaimer in front of the file is OK, it's even required.
But your additional "pointer" to the file, especially for a specific
distribution, doesn't make sense and won't be accepted. Remember that
your driver will be part of the lm_sensors project (BTW you header
should mention that, see the other drivers) so neither Debian's
/usr/doc/copyright/GPL not "the file COPYING in the Linux kernel source"
are part of the package. The COPYING file is part of the lm_sensors
package and people pretty well know where it is.

> > > +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> > > I2C_FUNC_SMBUS_WORD_DATA))+	{
> > > +		printk(KERN_ERR "Adapter doesn't support functionality.\n");
> > > +		goto error1;
> > > +	}
> > 
> > That's not an error. As you load an i2c chip driver, all adapters
> > will be scanned. This may include adapters that don't support these
> > functionalities (and so they just can't have a MAX6633 on them). I
> > wouldn't even print a message.
> 
> What about situation when chip is connected to unsupported adapter or
> adapter which doesn't provide needed functionality?
> Any reading/writing will confuse bus and reader/writer.
> I think chip should not work if it is not connected to the right
> adapter.

I don't say that you should skip the test. Just don't make it an error,
i.e. exit in silence.

The case where the chip is connected to an unsupported (I would say
unsupporting) adapter is a hardware design issue, we are not supposed to
handle that. If you really want to warn the user about it, it has to be
a debug message.

> > I notice that your driver has no detection mechanism at all. I agree
> > that the MAX6634 doesn't look like a chip that want to be identified
> > (no manufacturer ID registers, no chip ID register, no die/revision
> > registers...) but there is a common trick of checking for unused
> > bits, which always return 0. There are two of them in the
> > configuration register, and 7 more in each temperature limit
> > register. 30 zero bits verified is far better than no check at all.
> 
> One may not rely on control register.
> One of MAX663xes here has 1 in it's "reserved" field but working
> absolutely right.

Oh, OK. Unusual. This is why having physical samples when programming a
driver is very, very helpful.

> I have done "identification" based on reserved bits in MAX, LOW, HIGH
> and HYST registers.

OK, fine.

> > Also, since it seems that the address pointer registers only has 3
> > used bits, I would expect values to cycle every 8 registers. See
> > lm75.c as an example. Could you please provide an i2cdump of the
> > chip for confirmation (both byte and word modes)? I would then add
> > support for the MAX6633/4/5 and LM76 (which seems to be compatible,
> > but has different unused bits) to our sensors-detect script.
> 
> No, I can't.
> 
> ls /dev/i2c/
> -------------- dir /dev/i2c/ ----------
> 0                   ..                  .
> MSG[14]:ls /dev/i2c/
>  
> /bin/i2cdump 0 0x4f b
> New process started PID
> file: /bin/i2cdump
> MSG[23]:/bin/i2cdumpfile: /bin/i2cdump
>   WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>   I will probe file /dev/i2c/0, address 0x4f, mode byte
>   You have five seconds to reconsider and press CTRL-C!
>  
> ls /proc/13/
> scandir("/proc/13/")No such file or directory
> MSG[14]:ls /proc/13/
> 
> Without explicit fflush() one can't read output just after error with
> our embedded init.
> Or may be i2cdump doesn't like big endian ppc32 and cross-compilation.
> Don't know where exit happens in i2cdump.

Oh, OK. That's a special system you have here. I guess you also don't
intend to use sensors/libsensors, but only read/write the values through
procfs?

Will you be able to run sensors-detect to test my detection function on
your samples?

I would like you to test the 8-registers cycling in the driver itself.
In your detection function, just read limits registers + 8 and see if
you read the same four values. If can even be better to do that 32
times, to test the whole range. That's always interesting to ensure that
you are probing the right chip like that, especially when there's no
identification dedicated registers. See lm75.c for an example.

> Actually there is race here, since update may only happen in process
> context but any userspace reading is not protected.
> Now update_lock is using for protecting max663x_data when writing into
> it.

You're right, our drivers suffer from a race condition (although in most
cases it works fine). We're thinking of a solutions, just need some more
time to implement it.

> now one can read 5 values and write 4 values:
> read:   max, hyst, low, high, temp
> write:  max, hyst, low, high.

OK, fine with me.

> Please review and comment.
> If all design and technical issues are resloved I will make a patch
> against lm_sensors tree.

A few more things:

> +#define reg2temp(temp) ((temp & 0x8000)?(255 - (temp >> 7)):(temp >> 7))
> +#define temp2reg(temp) ((temp < 0)?(((temp + 255) << 7) | 0x8000):(temp << 7))

These conversion functions look broken for negative temperatures, please
check it. And even for positive ones, the ">> 7" looks like you are
working with 9-bit values, while the chip is supposed to handle 12-bit
ones (or even 13 with the sign?).

Likewise, I'm surprised by the fact that you export the values to
userspace with a single decimal place. If I'm correct and you have 5
bits for the non-integer part, you're losing a significant part of this
resolution when doing that.

> +	temp_low 	= swap_bytes(i2c_smbus_read_word_data(client, MAX663x_LOW));
> +	temp_high	= swap_bytes(i2c_smbus_read_word_data(client, MAX663x_HIGH));
> +	temp_hyst	= swap_bytes(i2c_smbus_read_word_data(client, MAX663x_HYST));
> +	temp_max	= swap_bytes(i2c_smbus_read_word_data(client, MAX663x_MAX));
> +
> +	return (!(temp_low & 0x7f) && !(temp_high & 0x7f) && !(temp_hyst & 0x7f) && !(temp_max & 0x7f));

You don't need swap_bytes here, if would be faster without it, don't you think?

>  error3:
> +	max663x_id--;
>  	kfree(new_client);

Interesting. None of our drivers do that. Not a big issue though.

And, again, please mass-rename max663x to max6635 (or any other). We
don't like 'x' in the driver names, function names, constant names, etc.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
