From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Thu, 28 Sep 2006 23:42:06 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <000101c6e357$b87bf870$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> 
> > isadump 0x2e 0x2f
> >
> > If you see all 0xff then the superio must be unlocked

Results are all 0xff

> > isadump -k 0x87,0x87 0x2e 0x2f

Again only 0xff


> 
> Try this
> 
> > or try -k 0x55
> 
> isadump -k 0x55 0x2e 0x2f

And yet again we see all 0xff


> 
> > question 5) answer: isadump -f 0x290

First time:
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: 06 00 00 35 86 00 00 c7 77 07 3f ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff ff a3 ff ff ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Second time straight after the first:
       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
0200: 06 00 00 35 86 00 00 c7 77 07 3f ff ff ff ff ff 
0210: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0220: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0230: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0240: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0250: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0260: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0270: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
0290: ff ff ff ff ff a0 01 ff ff ff ff ff ff ff ff ff 
02a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
02f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Ran on Jean's advice sensors-detect again and it reported when probing for
superior the following:

Probing for Super-I/O at 0x4e/0x4f
Trying family `ITE'...                                      No
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       Yes
Found unknown chip with ID 0x0541

Then did an isadump on 0x4e 0x4f and was shown a lot more 0xff :(
I looked at the driver code for the Fintek F71805F Super-I/O chip which uses
0x87 to as key to unlock.

Results for isadump -k 0x87 0x4e 0x4f
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 05 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 00 60 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 01 ff 0c ff ff ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

groeten,
Hans


