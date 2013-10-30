From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 30 Oct 2013 02:25:20 +0000
Subject: Re: [lm-sensors] Lenovo Yoga 13 with SMSC EMC2104 chip
Message-Id: <52706E10.2030809@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
In-Reply-To: <CAK0txenpNcwmNh4UqTaBzYE8Tu5uns+2EoVALK2+gn9DGJPEkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/29/2013 03:37 PM, Igor Popik wrote:
> 2013/10/29 Igor Popik <igor.popik@gmail.com>:
>> Hi Jean,
>>
>> 2013/10/29 Jean Delvare <khali@linux-fr.org>:
>>> Hi Igor,
>>>
>>> On Tue, 29 Oct 2013 19:14:14 +0100, Igor Popik wrote:
>>>> I added new adresses to emc2103 driver with no effect. I checked if
>>>> the module works  with trying to load i2c-stub module  with 0x2e &
>>>> other addresses - it triggers the device detection in the module.= but
>>>> of course without success as it is a dummy i2c device.
>>>>
>>>> After that I think I'm beginning to understand how it all works so I
>>>> ran i2cdetect
>>>>
>>>> # i2cdetect -l
>>>> i2c-0 i2c       i915 gmbus ssc                   I2C adapter
>>>> i2c-1 i2c       i915 gmbus vga                   I2C adapter
>>>> i2c-2 i2c       i915 gmbus panel                 I2C adapter
>>>> i2c-3 i2c       i915 gmbus dpc                   I2C adapter
>>>> i2c-4 i2c       i915 gmbus dpb                   I2C adapter
>>>> i2c-5 i2c       i915 gmbus dpd                   I2C adapter
>>>> i2c-6 i2c       DPDDC-D                         I2C adapter
>>>> i2c-7 smbus     SMBus stub driver               SMBus adapter (dummy
>>>> driver I played with)
>>>>
>>>> Should I see emc adapter there or not? I think I should.
>>>
>>> No, the EMC2104 chip is an I2C/SMBus client, not an I2C/SMBus master, so
>>> it's expected you don't see it in the list above. The EMC2104 chip is
>>> connected to one of the adapters. What is surprising is that I'd expect
>>> your motherboard's SMBus to show up in the adapter list but it's not
>>> there. Please check in lspci if you can see it. Then tell us which
>>> kernel you're running.
>>
>> My lspci output (Intel SMBus is visible):
>>
>> 00:00.0 Host bridge: Intel Corporation 3rd Gen Core processor DRAM
>> Controller (rev 09)
>> 00:02.0 VGA compatible controller: Intel Corporation 3rd Gen Core
>> processor Graphics Controller (rev 09)
>> 00:04.0 Signal processing controller: Intel Corporation 3rd Gen Core
>> Processor Thermal Subsystem (rev 09)
>> 00:14.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
>> Family USB xHCI Host Controller (rev 04)
>> 00:16.0 Communication controller: Intel Corporation 7 Series/C210
>> Series Chipset Family MEI Controller #1 (rev 04)
>> 00:1a.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
>> Family USB Enhanced Host Controller #2 (rev 04)
>> 00:1b.0 Audio device: Intel Corporation 7 Series/C210 Series Chipset
>> Family High Definition Audio Controller (rev 04)
>> 00:1d.0 USB controller: Intel Corporation 7 Series/C210 Series Chipset
>> Family USB Enhanced Host Controller #1 (rev 04)
>> 00:1f.0 ISA bridge: Intel Corporation QS77 Express Chipset LPC
>> Controller (rev 04)
>> 00:1f.2 SATA controller: Intel Corporation 7 Series Chipset Family
>> 6-port SATA Controller [AHCI mode] (rev 04)
>> 00:1f.3 SMBus: Intel Corporation 7 Series/C210 Series Chipset Family
>> SMBus Controller (rev 04)
>> 00:1f.6 Signal processing controller: Intel Corporation 7 Series/C210
>> Series Chipset Family Thermal Management Controller (rev 04)
>>
>> uname -a
>> Linux yoga-alien-13 3.11.0-12-generic #19-Ubuntu SMP Wed Oct 9
>> 16:20:46 UTC 2013 x86_64 x86_64 x86_64 GNU/Linux
>>
>>>>  From what I understand to instantiate a device from user space proper
>>>> entry in /sys/bus/i2c/devices/i2c-... has to exist.
>>>
>>> Yes, you need the /sys/bus/i2c/devices/i2c-<N> which corresponds to
>>> your SMBus.
>>>
>>>> Is it possible that EMC2104 in my laptop is somehow invisible to
>>>> OS/i2c bus? I'm sure it is there - I can send You a picture ;-)
>>>
>>> Yes, we've seen it before. The SMBus controller can be hidden, or made
>>> inaccessible to the OS due to ACPI resource conflicts, or the EMC2104
>>> could be behind and I2C switch/gate, or it could be connected using an
>>> arbitrary pair of GPIO pins and we'll never guess what they are...
>>
>>
>> After some googling& investigation in documentation of i2c-i801 driver
>> I found out that it should work for that chipset but in some cases can
>> be conflicted with ACPI (as You wrote above), and in my case it is
>> (messages after loading i2c-i801 driver):
>>
>> ACPI Warning: 0x0000000000002040-0x000000000000205f SystemIO conflicts
>> with Region \_SB_.PCI0.SBUS.SMBI 1 (20130517/utaddress-251)
>> ACPI: If an ACPI driver is available for this device, you should use
>> it instead of the native driver
>>
>
>
>
>> So I guess nothing can be done?
>
> I just added acpi_enforce_resources=lax to kernel i smbus is now visible:
>
>   i2cdetect -l
> i2c-0 i2c       i915 gmbus ssc                   I2C adapter
> i2c-1 i2c       i915 gmbus vga                   I2C adapter
> i2c-2 i2c       i915 gmbus panel                 I2C adapter
> i2c-3 i2c       i915 gmbus dpc                   I2C adapter
> i2c-4 i2c       i915 gmbus dpb                   I2C adapter
> i2c-5 i2c       i915 gmbus dpd                   I2C adapter
> i2c-6 i2c       DPDDC-D                         I2C adapter
> i2c-7 smbus     SMBus I801 adapter at 2040       SMBus adapter
>
>
> # i2cdetect 7
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will probe file /dev/i2c-7.
> I will probe address range 0x03-0x77.
> Continue? [Y/n]
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00:          -- -- -- -- -- 08 -- -- -- -- -- -- --
> 10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 30: -- -- 32 -- -- -- -- -- -- -- -- -- -- -- -- --
> 40: -- -- -- -- 44 -- -- -- -- -- -- -- -- -- -- --
> 50: -- -- 52 -- -- -- -- -- -- -- -- -- -- -- -- --
> 60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
> 70: -- -- -- -- -- -- -- --
>
> EMC2103 driver does not load (wrong manufacturer ID) - emc2103 device
> should appear at 0x2e - manual activation does not work either.
>

As Jean mentioned, there may be another i2c bus, a hidden i2c multiplexer,
or the chip may be connected to the IDT EC. The DSDT might give us
some hints. You already know from the ACPI overlap that ACPI talks with the
SMBus adapter; it might also talk with the EC. Can you extract the DSDT
and provide it to us ?

	sudo cat /sys/firmware/acpi/tables/DSDT > dsdt.aml

Then, in case you want to learn things you never really wanted to know:

	iasl -d dsdt.aml

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
