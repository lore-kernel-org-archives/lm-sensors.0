From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 13 Jan 2008 13:35:29 +0000
Subject: Re: [lm-sensors] no sensors were detected with Intel Corporation
Message-Id: <20080113143529.267a7e44@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
In-Reply-To: <c8faca170711081606t6acc5928hfdcd9200ba1d421f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kessia,

On Thu, 3 Jan 2008 12:50:04 -0200, Kessia Pinheiro wrote:
> > OK, so it was indeed an index/data pair. Now, if some of these register
> > values correspond to sensors, their values should change a little over
> > time. Try running the same isadump command a few seconds apart and see
> > if some values change. Do that while the fan is spinning, otherwise you
> > might miss it. Also try with and without CPU load to increase the
> > chances to spot a change.
> 
> I execute some times "isadump 0x910 0x911" and got differents values, like:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 59 ff 00 00 01 27 80 4c 00 00 00 07 37 39 37 39
> 90: 02 00 00 00 00 00 00 08 00 00 00 00 00 00 00 1e
> a0: 00 01 00 62 00 00 a9 30 50 14 b8 0b 0a 47 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> 
> and
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 23 00 00 00 01 27 80 4c 00 00 00 07 37 39 37 39
> 90: 02 00 00 00 80 00 00 08 00 00 00 00 00 00 00 43
> a0: 00 01 00 62 00 00 a9 30 50 14 b8 0b 0a 47 32 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I see the following changes:
Register 0x80 from 0x59 to 0x23
Register 0x81 from 0xff to 0x00
Register 0x94 from 0x00 to 0x80
Register 0x9f from 0x1e to 0x43
Register 0xae from 0x00 to 0x32

Unfortunately these changes don't really look like sensor value changes.
Sensor values typically change to values nearby, that's not the case
here. Without documentation, it looks like a dead end, sorry.

> > I also think that it would be worth taking a look at the ACPI
> > implementation of your laptop to see what they are doing with
> > temperatures and fans. We don't want to interfere with that. Can you
> > read the temperature using acpi?
> 
> Can i read:
> (...)
> # cat thermal_zone/THM/*
> <setting not supported>
> <polling disabled>
> state:                   ok
> temperature:             40 C
> critical (S5):           99 C

OK, so at least you can get your system temperature and it looks valid.
That's probably all you will get from your laptop, at least for the
time being. If you have the "acpi" client installed you can get the
temperature value with "acpi -t".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
