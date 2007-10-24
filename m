From: Riku Voipio <riku.voipio@movial.fi>
Date: Wed, 24 Oct 2007 14:03:28 +0000
Subject: Re: [lm-sensors] [PATCH] On n2100 systems,
Message-Id: <471F50B0.2040504@movial.fi>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071016100857.GA25544@kos.to>
In-Reply-To: <20071016100857.GA25544@kos.to>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Riku, Lennert,
>
> On Thu, 18 Oct 2007 11:56:04 +0300, Riku Voipio wrote:
>> Redboot does not touch the fans. The problem is that the fanspeed
>> reading isn't reliable. The "speed" mode tries to adjust pwm to get
>> the fanspeed to match whatever is requested in "expect" registers,
>> but never to enough to get the fans to run.
>
> I see. I have to admit that it isn't very smart from Fintek to set the
> "speed mode" by default on this chip. It would be safer to default to
> full speed. OTOH the default speed target seems to be 4297 RPM if I
> read the datasheet correctly, which is high enough. If the fan speed
> reading isn't reliable (which admittedly is a bad thing to start with)
> I'd expect the chip to set the fan output to the max. Isn't it the case?
>
If it would be setting fan speed to full speed by default
I would not be sending these patches in the first place...
>> With, say, 2x10 rpm disks inside the case, I'd say the risk of
>> disks breaking down prematurely is very real. And I do not
>> want to take the responsibility of people reporting that "installing
>> Debian caused my hardware to break down"
>
> I see. But I can't think of a reason why this can't be simply solved in
> user-space, as Thecus is doing in their own product. This would be much
> easier than the kernel patches you've been sending.
Exactly what should Debian ship in /etc/sensors.conf to make
f75375s turn fans on N2100 systems but nowhere else? Simple
my ASS. Last I read about operating systems, the bloody point
of kernel was to abstract hardware differences.

Conveying platform_data from board configs to drivers
is a well established practice to solve platform specific quirks.

Not to mention that these kind of safety measures should be
done as early as possible. And due to the reasons I already
gave, changing bootloader is not really a option, the kernel
is the next best thing.

>>> Can I see a dump of the chip before the Linux driver is loaded?
>> I'll grab it, but see the first paragraph I wrote.
>
> I'm still interested.
>
> Thanks,
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 01 03 82 40 5c 18 ff ff ff ff ff ff ff ff ff ff    ???@\?..........
10: d8 a8 d7 72 24 22 ff ff ff ff ff ff ff ff ff ff    ???r$"..........
20: ff 00 ff 00 ff 00 ff 00 3c 37 3c 37 ff ff ff ff    ........<7<7....
30: 00 00 00 00 00 f0 00 03 00 ff ff ff ff ff ff ff    .....?.?........
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
50: ff ff ff ff ff ff ff ff ff ff 03 06 15 19 34 ff    ..........????4.
60: 50 02 09 00 00 00 09 89 89 30 30 10 10 33 32 00    P??...???00??32.
70: ff ff ff ff ff ff 00 05 0a ff ff ff f5 00 ff ff    .......??...?...
80: ff ff ff ff ff ff 00 05 0a ff ff ff f5 00 ff ff    .......??...?...
90: 00 00 0d ff ff ff ff ff ff ff ff ff ff ff ff ff    ..?.............
a0: 3c 32 28 1e ff ff ff ff ff ff ff ff ff ff ff ff    <2(?............
b0: 3c 32 28 1e ff ff ff ff ff ff ff ff ff ff ff ff    <2(?............
c0: ae 04 ae 04 ff ff ff ff ff ff ff ff ff ff ff ff    ????............
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff    ................
f0: 80 80 00 00 00 03 5b 06 c0 00 00 ff ff ff ff 1d    ??...?[??......?




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
