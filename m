From: r.marek@assembler.cz (Rudolf Marek)
Date: Thu, 28 Sep 2006 21:20:29 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <451C3C9D.5040108@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Best would be to ask the for additional docs but lets check what we can find out
on our own:

> Results:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff 03 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
> 10: 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff 
> 20: d3 af ab 83 7a 8a 76 d6 c3 ff ff ff ff ff ff ff 
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 50: ff ff ff ff ff ff ff ff ff ff 03 04 10 19 34 ff 
> 60: 00 00 00 00 ff ff 02 74 00 00 ff 06 40 24 ff 00 
> 70: ff ff 2e ff 1f ff 00 ff ff ff ff ff ff ff ff ff 
> 80: ff ff 65 64 64 55 55 46 ff ff ff ff ff ff a8 ff 
> 90: 00 0c 0c 00 15 ff 57 ff 44 22 ff aa 55 55 ff 0a 
> a0: 01 d1 00 ff 02 23 3c 32 28 1e ff d9 b2 99 80 01 
> b0: 02 1b 00 99 02 1b 3c 32 28 1e ff d9 b2 99 80 02 
> c0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 
> d0: 0f ff 00 80 03 ff 3c 32 28 1e ff d9 b2 99 80 03 

Perhaps the chip can control the fans too. and set some limits... this would be
the undocumented a2-af fields

> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> f0: 00 00 00 00 00 00 37 ff 02 ff ff 02 ff ff ff ff
> 
> The results seem to be correct systemp is around the 30C as shown in the
> results from isadump and checked with the bios. 
> I do have my doubts about the cpu temp reported in the isadump it says it's
> around 45C but when checking in the bios it shows almost 60C. Could it be
> the rebooting that is causing the temp to rise so much?

Check Hans answer.

> Is it still necessary to unlock the superio and if so could to explain why?

Yes it would be good to know for detection.

> isadump 0x2e 0x2f
> 
> If you see all 0xff then the superio must be unlocked

Proceed


> 
> isadump -k 0x87,0x87 0x2e 0x2f

Try this

> or try -k 0x55

isadump -k 0x55 0x2e 0x2f

Or this ;)

> SO please try to "unlock" the superio first. I would bet that the key -k
> 0x55
> will work but check it out yourself ;)
> 
> ruik:/tmp# isadump -k 0x87,0x87 0x2e 0x2f 2
> WARNING! Running this program can cause system crashes, data loss and worse!
> I will probe address register 0x2e and data register 0x2f.
> Probing bank 2 using bank register 0x07.
> Continue? [Y/n] y
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff 02 ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 88 63 ff 00 80 00 00 ff 50 04 01 00 f0 21 00 ff
> 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 03 f8 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: 04 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff


The unlocked suoperIO looks like this. If you manage to see something like this
then proceed down to check what logical device the chip resides. Just switch do
dumps with

> ruik:/tmp# isadump -k 0x87,0x87 0x2e 0x2f 2

and change the last number from 0 1? to 15

and check the bytes at 60: you should see the 02 90 or 02 95

> question 5) answer: isadump -f 0x290

Please provide this dump too

Thanks, Rudolf

