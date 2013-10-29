From: Igor Popik <igor.popik@gmail.com>
Date: Tue, 29 Oct 2013 18:14:14 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <CAK0txemTHX1igFMtSOT1z=4Ra-hifROdOxZH4ENEqcCmEF0g6g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I added new adresses to emc2103 driver with no effect. I checked if
the module works  with trying to load i2c-stub module  with 0x2e &
other addresses - it triggers the device detection in the module.= but
of course without success as it is a dummy i2c device.

After that I think I'm beginning to understand how it all works so I
ran i2cdetect

# i2cdetect -l
i2c-0 i2c       i915 gmbus ssc                   I2C adapter
i2c-1 i2c       i915 gmbus vga                   I2C adapter
i2c-2 i2c       i915 gmbus panel                 I2C adapter
i2c-3 i2c       i915 gmbus dpc                   I2C adapter
i2c-4 i2c       i915 gmbus dpb                   I2C adapter
i2c-5 i2c       i915 gmbus dpd                   I2C adapter
i2c-6 i2c       DPDDC-D                         I2C adapter
i2c-7 smbus     SMBus stub driver               SMBus adapter (dummy
driver I played with)

Should I see emc adapter there or not? I think I should.

From what I understand to instantiate a device from user space proper
entry in /sys/bus/i2c/devices/i2c-... has to exist.

Is it possible that EMC2104 in my laptop is somehow invisible to
OS/i2c bus? I'm sure it is there - I can send You a picture ;-)

Igor

2013/10/29 Jean Delvare <khali@linux-fr.org>:
> Hi Guenter, hi Igor,
>
> On Sun, 27 Oct 2013 18:26:20 -0700, Guenter Roeck wrote:
>> (...) It should be possible to add support for EMC2104
>> to the EMC2103 driver, but someone would have to implement it.
>> If you want to hack, you could add the emc2104 device id (0x1d)
>> and the emmc2104 I2C address (0x2f) to the driver. That _should_
>> give you access to some of the temperature sensors and to one
>> of the fan controllers. No guarantee, though.
>
> For that kind of test, you don't even need to change the code. You can
> simply instantiate the device from user-space manually using method 4
> described in
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/i2c/instantiating-devices
>
> Whether it will work or cause your hardware to crash and burn, I can't
> say. I would be very cautious with a fan controller chip.
>
> Igor, could you please provide a register dump (using the i2c-dev
> driver + i2cdump from the i2c-tools package) of your EMC2104 chip?
>
> --
> Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
