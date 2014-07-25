From: Jean Delvare <jdelvare@suse.de>
Date: Fri, 25 Jul 2014 07:43:29 +0000
Subject: Re: [lm-sensors] not fan detected chromebook c720
Message-Id: <20140725094329.4bb829c9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <53D18E7E.4020308@gmail.com>
In-Reply-To: <53D18E7E.4020308@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 24 Jul 2014 17:53:50 -0500, Pietro Sammarco wrote:
> Hello people,
> 
> I have recently bought a brand new Acer chromebook c720 which I am using 
> with ArchLinux. Ever since I wiped out ChromeOS to install ArchLinux I 
> realized a smell of electronic burning coming from it. Digging around I 
> have realized lm-sensors does not detect the fan.

What did ChromeOS report with regards to hardware monitoring?

If this machine has anything which looks like a BIOS, what does it
report with regards to hardware monitoring?

Most laptops don't have traditional hardware monitoring chips,
everything is handled by ACPI magic and/or behind complex environment
controller chips.

> The chipset is a Lynx Point (PCH), therefore as according the wiki it 
> should work with the i2c-i801.
> 
> I am going to attach a bit of informations below.
> 
> Linux chromebookC720 3.16.0-1-mainline-chromebook #1 SMP PREEMPT Mon Jul 
> 14 22:04:51 NZST 2014 x86_64 GNU/Linux
> 
> [latrina@chromebookC720 ~]$ sudo i2cdetect -l
> i2c-0    i2c           i2c-designware-pci                  I2C adapter
> i2c-1    i2c           i2c-designware-pci                  I2C adapter
> i2c-2    smbus         SMBus I801 adapter at 0400          SMBus adapter
> i2c-3    i2c           i915 gmbus ssc                      I2C adapter
> i2c-4    i2c           i915 gmbus vga                      I2C adapter
> i2c-5    i2c           i915 gmbus panel                    I2C adapter
> i2c-6    i2c           i915 gmbus dpc                      I2C adapter
> i2c-7    i2c           i915 gmbus dpb                      I2C adapter
> i2c-8    i2c           i915 gmbus dpd                      I2C adapter
> i2c-9    i2c           DPDDC-A                             I2C adapter

I'm surprised by the designware stuff, instead I would expected
cros-ec-i2c-tunnel. Can you check if the i2c-cros-ec-tunnel driver is
loaded (as well as the cros_ec driver itself)?

> Hopefully someone will able to tell me what I am doing wrong.

Nothing, it's just a non-trivial case.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
