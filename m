From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Sep 2006 07:50:47 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20060929095047.acd76d50.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Ran on Jean's advice sensors-detect again and it reported when probing for
> superior the following:
> 
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `ITE'...                                      No
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0x0541

Great, it partly worked. It properly detected the address (0x4e/0x4f)
and the family. Contrary to my expectations, it failed to find the
logical device number though, I wonder why.

> Then did an isadump on 0x4e 0x4f and was shown a lot more 0xff :(
> I looked at the driver code for the Fintek F71805F Super-I/O chip which uses
> 0x87 to as key to unlock.

Actually the key for this family is double 0x87. You are lucky that it
worked with only one (below), in most cases it won't.

> Results for isadump -k 0x87 0x4e 0x4f
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 05 ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00
               ^^^^^
This confirms my earlier guess that this chip was designed by Fintek,
despite the Epox top marking.

> 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 00 60 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: 01 ff 0c ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Now I'd like to understand why sensors-detect didn't find the logical
device number. Please run the following command and provide the output
(assuming you use bash as your shell, and as root):

for ldn in `seq 0 15` ; do echo "=/ LDN=$ldn /=" ; isadump -y -k 0x87,0x87 0x4e 0x4f $ldn ; done

This will dump the first 16 logical devices (there are rarely more.) We
are looking for a logical device with 0x295 at 0x60. sensors-detect
would have detected that so I expect some trick though.

-- 
Jean Delvare

