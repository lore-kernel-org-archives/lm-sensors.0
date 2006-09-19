From: oe@hentges.net (Matthias Hentges)
Date: Tue, 19 Sep 2006 08:33:01 +0000
Subject: [lm-sensors] w83627ehf: Missing fan input and
Message-Id: <1158654781.29190.1.camel@mhcln03>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Ruduolf,

the dumps are attached. Thank you for spending your time on this issue
=)

Am Dienstag, den 19.09.2006, 09:11 +0200 schrieb Rudolf Marek:
> > 
> > Doesn't work for me :\ I still only get 4 fans.
> > Maybe you could add some debugging output?
> 
> Please provide dumps of:
> isadump 0x295 0x296
> isadump -k 0x87,0x87 0x2e 0x2f
> 
> Thanks,
> 
> Rudolf
-- 
Matthias 'CoreDump' Hentges 

Webmaster of hentges.net and OpenZaurus developer.
You can reach me in #openzaurus on Freenode.

My OS: Debian SID. Geek by Nature, Linux by Choice
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 b4 04 b4 10 2b 20 33 c0 b4 c0 c0 3c 3c 01 01 
10: 01 b4 70 00 00 01 01 3c 43 17 00 00 57 00 00 d1 
20: a3 ee d3 d3 d6 cc cc 28 71 5d 70 da 00 f7 ee ff 
30: 7f 57 ef 13 fd f1 fe bf db 3c 37 78 78 78 a8 96 
40: 03 02 00 de ff ff 00 04 2d ff 00 04 18 95 00 a3 
50: ff ff 80 ff ff ff 00 80 a1 6f ff ff 19 e4 ff 05 
60: 04 b4 43 2b c0 c0 3c ff 01 ff 01 ff ff ff ff ff 
70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: 04 b4 04 b4 10 2b 20 33 c0 b4 c0 c0 3c 3c 01 01 
90: 01 b4 70 00 00 01 01 3c 43 17 00 00 57 00 00 d1 
a0: a3 ee d3 d3 d6 cc cc 28 71 5d 70 da 00 f7 ee ff 
b0: 7f 57 ef 13 fd f1 fe bf db 3c 37 78 78 78 a8 96 
c0: 03 00 00 de ff ff 00 04 2d ff 00 04 18 95 00 a3 
d0: ff ff 80 ff ff ff 00 80 a1 6f ff ff 19 e4 ff 05 
e0: 04 b4 43 2b c0 c0 3c ff 01 ff 01 ff ff ff ff ff 
f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
-------------- next part --------------
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 0b ff ff ff ff ff ff ff ff 
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
20: 88 63 ff 00 54 00 00 ff 50 00 00 00 9a 21 00 ff 
30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
60: 02 90 ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
70: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
f0: c1 2e ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060919/746b738b/attachment.bin 
