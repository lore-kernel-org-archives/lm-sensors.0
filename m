From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Fri, 15 Sep 2006 21:02:19 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <450B14DB.2090505@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Sorry for delay, I'm quite busy with all the stuff and support for lm-sensors is
quite time consumptive. I hope I will have more time for lm-sensors during sunday.

Lets move the thread to this one.

I have seen the "datasheet" it should be enough to write a simple driver but we
need how to detect the superio in first place.

This should be easy to find out yourself:

you may try:
isadump 0x2e 0x2f

If you see all 0xff then the superio must be unlocked

isadump -k 0x87,0x87 0x2e 0x2f

or try -k 0x55

problem is that if none of standard key is working then best way would to ask them:

1) what is the superio unlocking key
2) what is the CR20 ID and what is CR21 revision. (what bits, what values)
3) what logical device is for hardware monitor, (so you can get the 0x290 base
addr from there)
4) is there any ID register in the 0x295/0x296 space?
5) how big is the 0x295 0x296 iospace? just from 0x290 + 8 bytes?
6) The Ultimate Question Of Life, the Universe and Everything

SO please try to "unlock" the superio first. I would bet that the key -k 0x55
will work but check it out yourself ;)

ruik:/tmp# isadump -k 0x87,0x87 0x2e 0x2f 2
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Probing bank 2 using bank register 0x07.
Continue? [Y/n] y
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 02 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 88 63 ff 00 80 00 00 ff 50 04 01 00 f0 21 00 ff
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

This example shows the unlocked superio and with listed bank 2,
Which is the serial port. At 0x60 you see the base addres: 3f8
you should see there 0x2 0x90 or 0x2 0x95, so cycle the banks from 0 to 15 This
would answer question 3)

question 2) answer is in 0x20 I have there 88 63  part 88 6 is chip ID rest is
revision

question 5) answer: isadump -f 0x290

0290: ff ff ff ff ff 47 90 ff ff ff ff ff ff ff ff ff

I have there just two bytes. Addtionaly you may check if the region is not
reserved by bios in the cat /proc/ioports

Or you can disassemble the bytecode of DSDT table, which will for sure contain
answer to question number 1)

Check the specs here:
http://perso.orange.fr/pierrelib/pnp/PnP_ISA_Spec_v1.0a.pdf

Or any Winbond superio datasheet.

Rudolf

