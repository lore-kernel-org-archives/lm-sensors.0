From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 01 Dec 2007 18:21:02 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <20071201192102.565009b6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 1 Dec 2007 15:16:07 -0200, Kessia Pinheiro wrote:
> isadump 0x910 0x911
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x910 and data register 0x911.
> Continue? [Y/n]
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 23 00 00 00 ff 1f 80 4c 00 00 00 07 37 39 37 39
> 90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
> a0: 00 01 01 4f ec f5 07 2d a8 0f 20 0c 06 01 37 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

OK, so it was indeed an index/data pair. Now, if some of these register
values correspond to sensors, their values should change a little over
time. Try running the same isadump command a few seconds apart and see
if some values change. Do that while the fan is spinning, otherwise you
might miss it. Also try with and without CPU load to increase the
chances to spot a change.

Note that the register map above looks like what the LPC47N252
datasheet describes. The bad news is that the chip does only fan speed
monitoring and control. On top of that, the fan speeds cannot be read
directly from the I/O space, so I don't even know how we would write a
driver. Someone would need to take a deeper look at the datasheet, I
don't have the time myself.

I also think that it would be worth taking a look at the ACPI
implementation of your laptop to see what they are doing with
temperatures and fans. We don't want to interfere with that. Can you
read the temperature using acpi?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
