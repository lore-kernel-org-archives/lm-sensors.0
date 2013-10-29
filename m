From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 29 Oct 2013 20:06:52 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <20131029210652.415281f9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Igor,

On Tue, 29 Oct 2013 19:14:14 +0100, Igor Popik wrote:
> I added new adresses to emc2103 driver with no effect. I checked if
> the module works  with trying to load i2c-stub module  with 0x2e &
> other addresses - it triggers the device detection in the module.= but
> of course without success as it is a dummy i2c device.
> 
> After that I think I'm beginning to understand how it all works so I
> ran i2cdetect
> 
> # i2cdetect -l
> i2c-0 i2c       i915 gmbus ssc                   I2C adapter
> i2c-1 i2c       i915 gmbus vga                   I2C adapter
> i2c-2 i2c       i915 gmbus panel                 I2C adapter
> i2c-3 i2c       i915 gmbus dpc                   I2C adapter
> i2c-4 i2c       i915 gmbus dpb                   I2C adapter
> i2c-5 i2c       i915 gmbus dpd                   I2C adapter
> i2c-6 i2c       DPDDC-D                         I2C adapter
> i2c-7 smbus     SMBus stub driver               SMBus adapter (dummy
> driver I played with)
> 
> Should I see emc adapter there or not? I think I should.

No, the EMC2104 chip is an I2C/SMBus client, not an I2C/SMBus master, so
it's expected you don't see it in the list above. The EMC2104 chip is
connected to one of the adapters. What is surprising is that I'd expect
your motherboard's SMBus to show up in the adapter list but it's not
there. Please check in lspci if you can see it. Then tell us which
kernel you're running.

> From what I understand to instantiate a device from user space proper
> entry in /sys/bus/i2c/devices/i2c-... has to exist.

Yes, you need the /sys/bus/i2c/devices/i2c-<N> which corresponds to
your SMBus.

> Is it possible that EMC2104 in my laptop is somehow invisible to
> OS/i2c bus? I'm sure it is there - I can send You a picture ;-)

Yes, we've seen it before. The SMBus controller can be hidden, or made
inaccessible to the OS due to ACPI resource conflicts, or the EMC2104
could be behind and I2C switch/gate, or it could be connected using an
arbitrary pair of GPIO pins and we'll never guess what they are...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
