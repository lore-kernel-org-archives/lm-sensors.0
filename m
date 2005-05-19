From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: Strange values on ASRock K7S8X mainboard with W83697 chip
Message-Id: <Pine.LNX.4.58.0407231228160.30300@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407221213.00965.lourens@rainbowdesert.net>
In-Reply-To: <200407221213.00965.lourens@rainbowdesert.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hmm. I guess I could try emailing ASRock, and see if they have
> anything to say about it. After staring at the numbers for a while
> I've noticed that they do vary slightly, so it's likely that
> something is actually connected. The raw values
> (/proc/sys/dev/sensors/w83697hf-isa-0290/in5) I've seen for in5 so
> far are 3.01 and 2.99 (187/188 on the ADC), in6 does 3.02 through
> 3.06 (189/191). I've also looked at the datasheet for the w83697hf
> now, but that didn't yield anything beyond that something strange
> is going on. My R3/R4 ratio appears to be about 25.4, and my R5/R6
> ratio is about 14.4, that is if my power supply is perfect. I guess
> I'll have to reboot to see what the BIOS says.
>


In the bios you will see:

32 Bit Transfer Mode
  Size
CPU Temperature
M/B Temperature
CPU Fan Speed
Chassis FAN Speed
Vcore
+ 3.30V
+ 5.00V
+ 12.00V
American Megatrends Inc.
P2.40


so I guess no negative  volatages

But in bios image there is something that is prepared for negative
volatges
eg000:206C                 cmp     ah, 25h ; '%'
Ieg000:206F                 jb      loc_0_209F

continue here if IN number is bigger eq than 25 (so in5 in6)

Ieg000:2071                 cmp     ah, 50h ; 'P'
Ieg000:2074                 jnb     loc_0_209F

continue here if register number is smaller than 50 (I must ask khali what
is it)

Ieg000:2076                 mov     byte ptr es:[si], 2Dh ; '-'

Here: write '-' before printing voltage !!!!


Ieg000:207A                 inc     si
Ieg000:207B                 mov     ah, 0A0h ; '?'
Ieg000:207D                 mul     ah
Ieg000:207F                 mov     cx, ax
Ieg000:2081                 mov     ax, 24h ; '$'
Ieg000:2084                 mul     bx

The BX value is somewhere hidden or even not included so I cant tell
anything about the formula.

Ieg000:2086                 sub     ax, cx
Ieg000:2088                 jnb     loc_0_208B
Ieg000:208A                 dec     dx
Ieg000:208B
Ieg000:208B loc_0_208B:                             ; CODE XREF:
Ieg000:208B                 push    ax
eg000:208C                 push    dx
Ieg000:208D                 mov     ax, 0Ah
Ieg000:2090                 mul     bx
Ieg000:2092                 mov     cx, 2710h
Ieg000:2095                 sub     cx, ax
Ieg000:2097                 pop     dx
Ieg000:2098                 pop     ax
Ieg000:2099                 div     cx
Ieg000:209B                 mov     bx, cx
Ieg000:209D                 jmp     short loc_0_20A7
Iseg000:20A7                 push    dx
Iseg000:20A8                 mov     dx, ax
Iseg000:20AA                 call    ascii
Iseg000:20AD                 mov     al, 2Eh ; '.'

Print decimal dot.

Iseg000:20AF                 call    sub_0_1F40
Iseg000:20B2                 pop     ax
Iseg000:20B3                 mov     dx, 3E8h
multiply by 1000 (3e8 is 1000 i think)
Iseg000:20B6                 mul     dx
Iseg000:20B8                 div     bx
Iseg000:20BA                 mov     dx, ax
Iseg000:20BC                 cmp     ax, 64h ; 'd'
Iseg000:20BF                 ja      loc_0_20CE
Iseg000:20C1                 mov     al, 30h ; '

In0, in2, in3, in4 has all constants included (so its supported by BIOS)
so I can derive the formulas if you really need them.
    label in0 "VCore 1"
    label in2 "+3.3V"
    label in3 "+5V"
    label in4 "+12V"

Please dont forget to CC to list.
Thanks.

Regards

Rudolf
