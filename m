From: "p. stephen w" <p.stephenwille@gmail.com>
Date: Tue, 12 Nov 2013 06:25:04 +0000
Subject: Re: [lm-sensors] Nuvoton NCT6791D support
Message-Id: <CADkjvt8YPEeiwB6j-xiW-gLKJgHmQ=iJ2v7zVCAD8AbP6+Kedg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
In-Reply-To: <CADkjvt_edGO-+NKbsUbNwN=DXod10WTUYmfjRTrQfYq_2no2uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Running sensors gives:
nct6791-isa-0290

Based on that the command becomes:
Mint stephen # isadump -k 0x55,0x55 0x905 0x906

Which outputs:
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff



If that's correct, I'll go a head and run the rest of them.




On Mon, Nov 11, 2013 at 9:22 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, Nov 11, 2013 at 08:05:46PM -0800, Guenter Roeck wrote:
>
> [ ... ]
>
> > No, it won't. I'll dig out other commands for you to run to give me some
> chip
> > register output.
> >
> Following up on this. It would be great if you can do the following.
>
> When executing the the sensors command, you see something like
>
> nct6791-isa-0a00
>
> for the NCT chip. Take the hex number at the end; based on it, run the
> following sequence of commands:
>
> sudo isadump -k 0x55,0x55 0xa05 0xa06
> sudo isadump -k 0x55,0x55 0xa05 0xa06 1
> sudo isadump -k 0x55,0x55 0xa05 0xa06 2
> sudo isadump -k 0x55,0x55 0xa05 0xa06 3
> sudo isadump -k 0x55,0x55 0xa05 0xa06 4
> sudo isadump -k 0x55,0x55 0xa05 0xa06 5
> sudo isadump -k 0x55,0x55 0xa05 0xa06 6
> sudo isadump -k 0x55,0x55 0xa05 0xa06 7
> sudo isadump -k 0x55,0x55 0xa05 0xa06 8
>
> In other words, add 5 and 6 to the hex number and pass it as parameter to
> the
> isadump commands.
>
> This should create a dump of chip registers, which would hopefully help me
> track
> down the problem with pwmX_temp_sel.
>
> Thanks,
> Guenter
>



-- 


_____________________________
Stephen Wille | pstephenwille.com
*new address p.stephenwille@gmail.com <p.stephenwille@gmail.com>*
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
