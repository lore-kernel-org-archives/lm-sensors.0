From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: PATCH: lm92: port for 2.6 kernel
Message-Id: <42234D28.5060404@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422318E5.4000201@katalix.com>
In-Reply-To: <422318E5.4000201@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:

>>The following patch adds 2.6 kernel support to the lm92 driver from
>>sensors-2.9.0. Tested with linux-2.6.11-rc5 on ppc32.
> 
> Damn. I have done the exact same work one week ago... I have set a link
> to my patch on our "Supported Devices" page, but maybe I should have
> advertised more about it. I'm really sorry we duplicated the work.

When do you plan to push the work to the 2.6 kernel? Is there a
BitKeeper kernel tree for I2C changes?

>>- fix endian bugs - use cpu_to_le16(), not swab16()
> 
> I do not think there actually is a bug. The SMBus specs say that word
> values are transmitted LSB first (hint: SMBus was developed by Intel).
> The LM92 (and every other hardware monitoring chip I know of, for that
> matter) transmits MSB first. Rationale for this is that it allows people
> not interested in decimals to only read the MSB, or so I read. So the
> swab16() is there for this reason, which isn't related to the CPU of
> the host system in any way.

I thought the I2C devices pulled data from devices as a byte stream.
Don't the i2c_smbus_[read|write]_word_data() routines pass the u16
data in little endian format because that's the endian of the SMbus?

Surely if swab16() is used rather than cpu_to_le16(), different values
are passed to the xxx_word_data() routines depending on cpu endian?

> If you really needed to do that change for the lm92 driver to work
> properly, then I would suspect a bug in the i2c bus driver you are
> using. Which is it, BTW?

My CPU is a ppc. On big endian CPUs, cpu_to_le16() and swab16() are
equivalent. It's little endian CPUs that I'm worried about...

The I2C bus driver is a mv64x60 (Marvell Discovery). The driver was
recently written by Mark Greer. I'm cc'ing him on this.

>>- if max6635 is detected, show a different device name in sysfs
> 
> I had done this in the first place too, but now I am not sure it is a
> good idea. Doing this requires adding some code to libsensors, sensors
> and about every program relying on libsensors. I don't think it's
> worth the effort, especially since the LM92 doesn't seem to be found on
> any PC motherboard. 

Looking at other drivers, they put different chip names into sysfs
even though the drivers work in exactly the same way for each chip.
So why not LM92?

I think it's really useful to identify the exact chip name now that it's
easy to do so with 2.6. In fact I was going to submit another patch
to differentiate the 6633/6634/6635 devices too.

Why does the libsensors code care what the chip is called? It knows the
driver name from the /sys/bus/i2c/drivers/xxx directory entry...

> I suspect it is actually only found on homebrew
> designs. Is it your case? 

My board is a commercial ppc32 VME card.

 > The MAX6635 is really a clone of the LM92, so
 > I see little benefit in having a separate prefix.

Well lm90 has 4 other compatible devices. The driver puts those chip
names out into /sysfs... Why make another rule for lm92?

The /sys/bus/i2c files should be as accurate and meaningful as possible.

> My patch for the new lm92 driver is here:
> http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc4-bk5-i2c-lm92.diff
> 
> It is known to be broken, in particular setting limits doesn't work. I
> have fixed almost everything yesterday. I'll finish the job this
> evening, then I'll publish the new version, and would be very happy if
> you could test it.

Sure I'll test it. I'll wait until you post the new version.

> Of course another possibility would be that we go with your patch.
> However, since I have a great experience with hardware monitoring
> drivers in Linux 2.6, it's likely that there will be less fixes
> required if we start from my version. Also, for the lm92 I did not
> really port the original driver but merely rewrote it, because the
> original driver was very different from the other ones, making code
> maintainance over time much harder.

I don't care which version we go with as long as it works and someone
is working on getting it integrated into the kernel tree.

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
