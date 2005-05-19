From: lourens@rainbowdesert.net (Lourens Veen)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <200407232114.05936.lourens@rainbowdesert.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri 23 July 2004 12:41, Rudolf Marek wrote:
> > Hmm. I guess I could try emailing ASRock, and see if they have
> > anything to say about it. After staring at the numbers for a
> > while I've noticed that they do vary slightly, so it's likely
> > that something is actually connected. The raw values
> > (/proc/sys/dev/sensors/w83697hf-isa-0290/in5) I've seen for in5
> > so far are 3.01 and 2.99 (187/188 on the ADC), in6 does 3.02
> > through 3.06 (189/191). I've also looked at the datasheet for
> > the w83697hf now, but that didn't yield anything beyond that
> > something strange is going on. My R3/R4 ratio appears to be
> > about 25.4, and my R5/R6 ratio is about 14.4, that is if my
> > power supply is perfect. I guess I'll have to reboot to see
> > what the BIOS says.
>
> In the bios you will see:
>
> 32 Bit Transfer Mode
>   Size
> CPU Temperature
> M/B Temperature
> CPU Fan Speed
> Chassis FAN Speed
> Vcore
> + 3.30V
> + 5.00V
> + 12.00V
> American Megatrends Inc.
> P2.40

I've still got version P2.20, but the ASRock changelog doesn't say 
anything about sensors.

>
> so I guess no negative  volatages
>
> But in bios image there is something that is prepared for
> negative volatges

How did you get that BIOS image? Is there a way to extract it? I'd 
love to have a look. I tried downloading the images from the ASRock 
website, but they don't even have those strings in them. Or am I 
missing something?

> eg000:206C                 cmp     ah, 25h ; '%'
> Ieg000:206F                 jb      loc_0_209F
>
> continue here if IN number is bigger eq than 25 (so in5 in6)
>
> Ieg000:2071                 cmp     ah, 50h ; 'P'
> Ieg000:2074                 jnb     loc_0_209F
>
> continue here if register number is smaller than 50 (I must ask
> khali what is it)

According to the data sheet, register mappings between 25h and 50h 
are:

20h-3Fh Monitor Value Registers
49h VID<4>/Device ID
4Ah Temperature 2, 3 Serial Bus Address
4Bh-4Dh Control Register
4Eh Select bank for 50h-5Fh Reg.
4Fh Winbond vendor ID

50h-5Fh are mapped to 5 different banks which are apparently 
selected through register 4Eh. I guess this 50h limit is pretty 
arbitrary...

> Ieg000:2076                 mov     byte ptr es:[si], 2Dh ; '-'
>
> Here: write '-' before printing voltage !!!!
>
>
> Ieg000:207A                 inc     si
> Ieg000:207B                 mov     ah, 0A0h ; '?'
> Ieg000:207D                 mul     ah
> Ieg000:207F                 mov     cx, ax
> Ieg000:2081                 mov     ax, 24h ; '$'
> Ieg000:2084                 mul     bx

Hmm, multiply by 160. The LSB of the ADC output is 16mV. So we're 
working in tenths of millivolts apparently.

> The BX value is somewhere hidden or even not included so I cant
> tell anything about the formula.

Well, I worked it out from that disassembly, and we can say 
something about the formula. If I didn't make any mistakes, it 
seems to follow the formula in the datasheet, with the mysterious 
BX being the beta value. The 24h (36) in there is the 3.6V 
reference voltage. This means that my original estimate is probably 
somewhere near correct, but it leaves the problem of the resolution 
being way too small.

Theory: the hardware guys at ASRock miswired in5 and in6. The BIOS 
software guys programmed the BIOS according to the datasheet. When 
testing, they noticed the problem, and disabled the negative 
voltage readout. It is a low-budget product after all, so fixing 
the hardware might simply have been too expensive. And negative 
voltages are hardly used in todays PCs anyway.

I've emailed ASRock, whose first reaction was to tell me to try the 
program at http://mbm.livewiredev.com. I took a second try at 
explaining them that I'm running Linux, and that I would like to 
know the formulas. I haven't had any response so far, but it's only 
been half a day. We'll see what happens.

> Please dont forget to CC to list.

Of course.

Cheers,

Lourens
-- 
GPG public key: http://home.student.utwente.nl/l.e.veen/lourens.key

