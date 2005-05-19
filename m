From: lourens@rainbowdesert.net (Lourens Veen)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <200407222258.31591.lourens@rainbowdesert.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu 22 July 2004 16:36, Rudolf Marek wrote:
> Hello,
>
> > The positive values seem to be alright. -12V and -5V obviously
> > aren't. Fan1 (the CPU fan) seems to be okay, but Fan2 (case
> > fan) gives 0 rpm, even though it is actually running.
> > Temperature readings do work.
>
> The voltages might use non-standart circuit, only chance getting
> this working is bios disassembly. Second reason might be that it
> is actualy unconnected.

Hmm. I guess I could try emailing ASRock, and see if they have 
anything to say about it. After staring at the numbers for a while 
I've noticed that they do vary slightly, so it's likely that 
something is actually connected. The raw values 
(/proc/sys/dev/sensors/w83697hf-isa-0290/in5) I've seen for in5 so 
far are 3.01 and 2.99 (187/188 on the ADC), in6 does 3.02 through 
3.06 (189/191). I've also looked at the datasheet for the w83697hf 
now, but that didn't yield anything beyond that something strange 
is going on. My R3/R4 ratio appears to be about 25.4, and my R5/R6 
ratio is about 14.4, that is if my power supply is perfect. I guess 
I'll have to reboot to see what the BIOS says.

These values work out to the following lines in the configuration 
file.

compute in5 (26.44 * @) - 91.58  , (@ + 91.58) / 26.44
compute in6 (15.36 * @) - 51.69  ,  (@ + 51.69) / 15.36

Note the huge multipliers, the values are jumping up and down in 
increments of about 0.3V for the -5V and 0.5V for the -12V now. 
That's way too much, so I'm guessing ASRock changed the offset 
voltage as well.

I've emailed them, we'll see what happens.

Incidentally, the values for +5 and +12 seem to be off as well, at 
4.84V and 11.25V. I'm ready to chalk that up to the use of cheap 
large-tolerance resistors though. I did the numbers based on the 
datasheet and assuming my +12v really is +12v, R1/R2 works out to 
be about 3.0, which is about 8% higher than the 28K/10K given in 
the datasheet. That's within the margins for 5% resistors.

> You can add ignore statements to /etc/sensors.conf.
>
> First find your chip configuration part and use the
> ignore statement.
>
> like ignore inX where X would corresspond to the label inX
> statement. ignore in6
> ignore in5

But that wouldn't solve anything... Although it would look prettier 
:-).

> For the fan there might be two reasons
>
> 1) fan3 is ignored via the config file
> 2) fan2 has wrong divisor set
>
>    set fan2_div 4
> (try 8)

Aha! Setting the divisor to 4 did the trick here. Thanks!

Lourens
-- 
GPG public key: http://home.student.utwente.nl/l.e.veen/lourens.key

