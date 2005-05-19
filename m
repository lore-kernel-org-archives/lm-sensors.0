From: warp-9.9@usa.net (Leif W)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <008a01c4978d$068292e0$0a01a8c0@enterprise>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> ----- Original Message ----- 
> From: "Jean Delvare" <khali@linux-fr.org>
> To: "Leif W" <warp-9.9@usa.net>
> Cc: <sensors@Stimpy.netroedge.com>
> Sent: Friday, September 10, 2004 17:15
> Subject: Re: Support DB Entry 1770
>
> I took a look at the driver, trying to figure out where it thinks your
> chip should not be used. Please apply the attached patch and recompile
> the driver, then repeat the tests. Hopefully this will yield more
> information.

i2c-isa loads fine.  w83781d fails at step 2.

=> /var/log/syslog <=
Sep 10 19:15:10 defiant kernel: i2c_adapter i2c-0: registered as adapter
#0

<defiant> [2004-09-10@19:15:17] ~ -> modprobe w83781d

=> /var/log/syslog <=
Sep 10 19:15:25 defiant kernel: i2c-core: driver w83781d registered.
Sep 10 19:15:25 defiant kernel: i2c_adapter i2c-0: found normal isa
entry for adapter 9191, addr 0290
Sep 10 19:15:25 defiant kernel: i2c_adapter i2c-0: Detection of w83781d
chip failed at step 2

> I would also appreciate the output of "isadump 0x295 0x296".

Here's the output before I loaded any modules.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
30: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
40: 01 d8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
50: 00 7f 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
60: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
70: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
b0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
c0: 01 00 00 ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
d0: 01 75 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
e0: 7e 7d de b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
f0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00

Here's the output after I loaded i2c-isa and w83781d.

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
30: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
40: 01 c8 0f ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
50: 02 56 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
60: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
70: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
b0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00
c0: 01 00 00 ff 7f 00 40 a0 2d 01 01 40 01 95 80 5c
d0: 03 45 80 ff ff ff 00 80 11 ff ff ff ff ff ff ff
e0: 7d 7d df b5 c7 d7 ca 1c ff 5c ff ff 00 ff 00 ed
f0: b0 80 24 00 c2 08 24 00 00 c0 a1 00 20 06 00 00

I tried another isadump later and diff'ed the results and some lines
were different.  I guess it's constantly changing?  This is the sensor
data?

Leif


