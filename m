From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: ATXP3 and ATXP5
Message-Id: <42777DB5.9010802@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4277310B.9060700@sh.cvut.cz>
In-Reply-To: <4277310B.9060700@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

i2cdump will produce all 0 except 0xA register that will be 0xFF
I can try to set manual speeds in BIOS and see what is programmed.
Do you want me to do this? (I dont need it by myself but maybe you can improve the detection stuff)

This is when I wrote to cpu0_vid some VID voltage...

I will probe file /dev/i2c-0, address 0x37, mode byte
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 0e 00 00 00 00 00 0f 00 00 00 ff 00 00 00 00 00    ?.....?.........
10: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
20: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
30: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
40: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e    ????????????????
50: 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0e 0c    ????????????????
60: 0c 0c 0c 0c 0c 0c 0c 0c 0c 0c 04 04 04 04 04 04    ????????????????
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................



REG0 changed and REG6 became 0xF


Regards

Rudolf


> 
> Bye,
> Sebastian
> 
