From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <qcBx2maQ.1098191377.2249470.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Richard,

>Can confirm this is 2.8.8 for both i2c and lm_sensors. init=0 does not
>help, changes sensors{1,2,3} to 2, which gives even more wrong temps.
>Changed the code (those lines don't appear to be skipped with init=0)
>and that had exactly the same effect. This was cold rebooting every time.

OK... Not much hope is left then. We can continue digging up if you want,
but know that this will probably not lead us anywhere.

>Without driver, from a cold reboot. the output of isadump 0xC05 0xC06 is:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>20: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
>30: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
>40: 01 de 1f ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
>50: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
>60: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
>70: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
>80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>a0: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
>b0: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
>c0: 01 00 00 ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
>d0: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
>e0: 5a a4 69 ba a1 ad a3 19 1a 19 ff 61 47 61 47 ed
>f0: b0 43 10 13 00 06 51 07 00 10 21 00 94 00 00 00
>and then loading the isa driver the output changes to:
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
>00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>20: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
>30: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
>40: 01 de 1f ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
>50: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
>60: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
>70: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
>80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>a0: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
>b0: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00
>c0: 01 00 00 ff 3f 00 00 0e 2d 02 01 00 18 95 80 5c
>d0: ff ff 00 ff ff ff 00 80 21 00 ff ff 11 ef ff 05
>e0: 5b a4 69 ba a1 ad a4 18 1a 19 ff 61 47 61 47 ed
>f0: b0 43 10 13 00 06 51 07 00 90 21 00 94 00 00 00

Differences in row 0x20 are not significant, these are the registers
holding the measurements so slight changes are expected. The only
register changing is 0x39, which, according to the driver code,
represents the high limit for temp1. Strangely, the original value is 16
degrees, which is odd, and the new one is -112 degrees if I'm not
mistaking, which is even stranger. Did you only load the driver, or did
you additionally run "sensors -s"? I'd guess the former, then it's
strange that this limit changed.

The Winbond chips are a bit more complex than the others, and have some
registers located in different "banks" which isadump will not show by
default. Please redo the same test (dump before load, dump after load)
with the following commands:
isadump 0xC05 0xC06 1
isadump 0xC05 0xC06 2
(you can do both in a row)

This will show the information for temp2 and temp3, respectively. I
wonder if we will observe a similar change we saw for temp1.

Jean
