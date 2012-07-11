From: "richardvoigt@gmail.com" <richardvoigt@gmail.com>
Date: Wed, 11 Jul 2012 15:26:30 +0000
Subject: Re: [lm-sensors] (no subject)
Message-Id: <CAO_2OxXdVraavs-Lwo4XYaq5m5Uk8t466ZQ_LAKVH=6SfkZ3+g@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
In-Reply-To: <200703231349.l2NDnj1q025087@whb1.seed.net.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If the purpose is to clear a single bit, wouldn't code of the form

    old & ~bit

be better?

On Wed, Jul 11, 2012 at 9:45 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Wed, Jul 11, 2012 at 04:16:21PM +0200, Stevie Trujillo wrote:
> [ ... ]
>>
>> > If that works, then please unload the driver and reload with write=2.
>> > This will log every register write right before it happens. So the last
>> > message logged is likely to point to a register write which is
>> > inappropriate for your device/board.
>>
>> I only see these lines:
>> [  265.408976] it87: Found IT8728F chip at 0xa30, revision 1
>> [  265.410655] it87: Beeping is supported
>> [  265.411583] it87: Writing value 0x37 to register 0x0c
>> [  265.423124] it87: Writing value 0x13 to register 0x00
>>
> Jean,
>
> it87_write_value(data, IT87_REG_CONFIG,
>                  (it87_read_value(data, IT87_REG_CONFIG) & 0x36)
>                         | (update_vbat ? 0x41 : 0x01));
>
> Unless I am missing something, the above code enables interrupts by clearing
> bit 3. In combination with having bit 1 set, this means that SMI# interrupts
> will be enabled. Default value for the register, at least for IT8721F and
> IT8718F, is 0x18. Replacing the 0x36 mask above with 0x3e might possibly solve
> the problem.
>
> Guenter
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
