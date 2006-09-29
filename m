From: hans.edgington@xs4all.nl (Hans Edgington)
Date: Fri, 29 Sep 2006 10:32:23 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <000901c6e3b2$961748b0$20140a0a@EA002>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

> 
> Actually the key for this family is double 0x87. You are lucky that it
> worked with only one (below), in most cases it won't.
> 

With the double 0x87 key I get the following results:

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
f0: 83 00 f0 ff ff ff ff ff ff ff ff ff ff ff ff ff

> Now I'd like to understand why sensors-detect didn't find the logical
> device number. 

Forgot to copy paste the last line:
(logical device 4 has address 0x295, could be sensors)

> Please run the following command and provide the output
> (assuming you use bash as your shell, and as root):
> 
> for ldn in `seq 0 15` ; do echo "=/ LDN=$ldn /=" ; isadump -y -k
> 0x87,0x87 0x4e 0x4f $ldn ; done
> 
> This will dump the first 16 logical devices (there are rarely more.) We
> are looking for a logical device with 0x295 at 0x60. sensors-detect
> would have detected that so I expect some trick though.

Ok here is the full dump

=/ LDN=0 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 00 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 03 f0 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 06 ff ff ff 02 ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 0e ff ff ff 00 ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=1 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 01 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 03 f8 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 04 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=2 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 02 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 04 5d ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=3 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 03 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 03 78 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 07 ff ff ff 04 ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 38 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=4 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 04 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 02 95 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=5 /=
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
f0: 83 00 f0 ff ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=6 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 06 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: 00 0f 03 00 ff ff ff ff ff ff ff ff ff ff ff ff 
c0: 00 0f 09 00 ff ff ff ff ff ff ff ff ff ff ff ff 
d0: 07 02 f2 07 ff ff ff ff ff ff ff ff ff ff ff ff 
e0: 00 ff 2a 00 ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 80 ff 86 00 ff ff ff ff ff ff ff ff ff ff ff ff 
=/ LDN=7 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 07 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 02 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: 06 00 00 35 86 00 00 c7 77 07 3f ff ff ff ff ff 
=/ LDN=8 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 08 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
f0: 10 00 01 20 00 00 00 03 00 ff 00 00 00 00 00 00 
=/ LDN=9 /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 09 ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0a ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
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
f0: 00 63 ff ff 16 1c 00 ff ff ff ff ff ff ff ff ff 
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0b ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0c ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0d ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0e ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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
=/ LDN /=
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff 00 ff ff ff ff 0f ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00 
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

Hans Edgington


