From: Stevie Trujillo <stevie.trujillo@gmail.com>
Date: Wed, 11 Jul 2012 16:36:49 +0000
Subject: Re: [lm-sensors] GA-Z77X-UD3H with ITE IT8728F, modprobe it87 freezes system
Message-Id: <6cc2cca145095b9effcfdb7228885ec9@cnu.no-ip.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
In-Reply-To: <CAJiZuY3QBnkcAsisvbg9pEzMt044aVBF+vwzrCHsGTS_N9ez1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 2012-07-11 18:10, Jean Delvare wrote:
> On Wed, 11 Jul 2012 07:45:56 -0700, Guenter Roeck wrote:
>> On Wed, Jul 11, 2012 at 04:16:21PM +0200, Stevie Trujillo wrote:
>> [ ... ]
>> >
>> > > If that works, then please unload the driver and reload with 
>> write=2.
>> > > This will log every register write right before it happens. So 
>> the last
>> > > message logged is likely to point to a register write which is
>> > > inappropriate for your device/board.
>> >
>> > I only see these lines:
>> > [  265.408976] it87: Found IT8728F chip at 0xa30, revision 1
>> > [  265.410655] it87: Beeping is supported
>> > [  265.411583] it87: Writing value 0x37 to register 0x0c
>> > [  265.423124] it87: Writing value 0x13 to register 0x00
>> >
>> Jean,
>>
>> it87_write_value(data, IT87_REG_CONFIG,
>>                  (it87_read_value(data, IT87_REG_CONFIG) & 0x36)
>> 			| (update_vbat ? 0x41 : 0x01));
>>
>> Unless I am missing something, the above code enables interrupts by 
>> clearing
>> bit 3. In combination with having bit 1 set, this means that SMI# 
>> interrupts
>> will be enabled. Default value for the register, at least for 
>> IT8721F and
>> IT8718F, is 0x18.
>
> The meaning of all bits in this register, and its default value, did
> not change since the IT8705F, at least up to the IT8721F. I do not 
> have
> the datasheet for the IT8728F, do I cannot comment on that. Maybe
> something changed for that chip, or - more likely - it is wired or
> configured in an unusual way on Stevie's board.
>
> A bit of archeology teaches us that the mysterious 0x36 mask comes 
> from
> this commit 8 years ago:
> 
> http://git.kernel.org/?p=linux/kernel/git/tglx/history.git;a=commitdiff;h0678638d86ea855f89fe5c799d146af7a75b64e
>
> Before that the mask was 0xb7, which wasn't that different given that
> bit 7 always reads back 0, and bit 0 is about be set anyway. I think
> 0x80 was removed to avoid an unlikely double-reset of the chip when 
> the
> module is loaded with reset=1.
>
> The 0xb7 is from the very first version of the it87 driver by
> Christophe Gauthron 11 years ago. I have no idea why bit 3 was
> explicitly cleared back then.
>
>> Replacing the 0x36 mask above with 0x3e might possibly solve
>> the problem.
>
> Indeed. I'm not too sure what to do about bit 5, BTW, it might be
> self-clearing as bit 7.
>
> Stevie, I have updated the driver at:
>   http://khali.linux-fr.org/devel//misc/it87/
>
> Please test it (make sure you don't get a cached version from your
> browser - line 2390 should have mask 0x3e.)

Hello, sorry for destroying subject and threading last time!

The new version doesn't freeze the system.

I also took the libery of adding a printk showing the old value.
2388 .   /* Start monitoring */
2389 .   printk("IT87_REG_CONFIG oldvalue: %x\n",
2390 .   .   it87_read_value(data, IT87_REG_CONFIG));

[   75.539096] it87: Found IT8728F chip at 0xa30, revision 1
[   75.539114] it87: Beeping is supported
[   75.539280] it87: Writing value 0x37 to register 0x0c
[   75.549437] IT87_REG_CONFIG oldvalue: 1b
[   75.549448] it87: Writing value 0x1b to register 0x00

--
Stevie Trujillo

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
