From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 02 Nov 2008 09:07:02 +0000
Subject: Re: [lm-sensors] ACPI reads wrong temperature after loading
Message-Id: <20081102100702.758eb70b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081101103904.7ea43d94@hyperion.delvare>
In-Reply-To: <20081101103904.7ea43d94@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Peter, Markus,

On Sat, 01 Nov 2008 23:16:56 +0100, Peter Mahlknecht wrote:
> I got the new kernel (2.6.27.4) running, here is what it outputs during boot:
> Nov  1 22:48:30 laptop-mali kernel: [    9.670886] i801_smbus 0000:00:1f.3: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> Nov  1 22:48:30 laptop-mali kernel: [    9.670946] ACPI: I/O resource 0000:00:1f.3 [0x18e0-0x18ff] conflicts with ACPI region SMBI [0x18e0-0x18ef]
> Nov  1 22:48:30 laptop-mali kernel: [    9.671002] ACPI: Device needs an ACPI driver

OK. This confirms that ACPI is using the SMBus so we shouldn't. With
kernels >= 2.6.27, you can boot with parameter
acpi_enforce_resources=strict and the i2c-i801 driver will decline
attaching to the SMBus.

> as just wrote before, as long as i2c-i801 isn't loaded i get the right
> temperatures, also if em28xx_cx25843 or lm90 (or both) are loaded. 
> dmesg output from my notebook can be found here:
> http://stud3.tuwien.ac.at/~e0526314/dmidecode_log

OK, thanks. We may use the DMI data to blacklist your laptop from
i2c-i801, although I'd prefer to use an ACPI-based approach.

Another test I'd like you to do is:

# rmmod em28xx_cx25843
# rmmod lm90
# modprobe i2c-i801
# modprobe i2c-dev
# i2cdetect -l
(find the i2c bus number for "SMBus I801 adapter at 18e0")
# i2cdetect n
(where n is the bus number in question)

I wonder if this will confuse ACPI the same way loading em28xx_cx25843
does. I don't think em28xx_cx25843 does more to the SMBus that
i2cdetect will, so I _think_ i2cdetect should cause the same problem.
But I'd like a confirmation, because I am surprised that just probing
the bus causes the problem.

Markus, this problem could be mitigated if em28xx_cx25843 was properly
checking the class of i2c adapters it is going to probe. The
cx25843_attach_adapter function should look like this:

static int cx25843_attach_adapter(struct i2c_adapter *adapter)
{
	if (!(adapter.class & I2C_CLASS_TV_ANALOG))
		return 0;
	printk(KERN_INFO"cx25843.c: starting probe for adapter %s (0x%x)\n",
		adapter->name, adapter->id);
	return i2c_probe(adapter, &addr_data, &cx25843_detect_client);
}

For future kernels, it should even be converted to the new-style i2c
device driver matching model, so that you don't have to probe anything.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
