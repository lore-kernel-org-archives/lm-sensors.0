From: Iain Paton <ilp@lkml.darkvoyage.org.uk>
Date: Sat, 13 Sep 2008 09:58:05 +0000
Subject: Re: [lm-sensors] New winbond chip: W83667HG
Message-Id: <48CB8EAD.9090807@lkml.darkvoyage.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807072054.10321.phhusson@free.fr>
In-Reply-To: <200807072054.10321.phhusson@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf Marek wrote:
> Please can you try the patch for sensors-detect? It should detect the chip.

The patch lets sensors-detect see the chip ok.

Output of the commands you asked for from a base P5Q

WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Probing bank 0 using bank register 0x4e.
Continue? [Y/n] y
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 04 9b 04 3d 30 00 46 20 01 9b 01 01 3c 3c 04 04
10: 04 ff 30 00 00 01 01 3c 43 17 00 00 2a ff ff cc
20: 82 d5 cd cb d0 ff 9f 23 ff 40 ff da 00 d0 c4 02
30: 60 26 0c 15 10 62 80 95 20 71 1c 03 06 01 81 ff
40: 03 ce 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
50: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 44 04 05
60: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
70: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 23 ff
80: 04 9b 04 3d 30 00 46 20 01 9b 01 01 3c 3c 04 04
90: 04 ff 30 00 00 01 01 3c 43 17 00 00 2a ff ff cc
a0: 82 d5 cd cb d0 ff 9f 23 ff 40 ff da 00 d0 c4 02
b0: 60 26 0c 15 10 62 80 95 20 71 1c 03 06 01 81 ff
c0: 03 00 00 ff ff 00 3f 35 2d 21 20 40 10 95 00 a3
d0: ff ff 00 ff ff ff 00 80 c1 6f ff ff 19 44 04 05
e0: 04 3d 50 00 01 01 3c ff 0a ff 01 ff ff ff ff 28
f0: 46 46 46 46 46 37 ff ff ff ff ff 4b 22 00 23 ff

WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 02 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: a5 13 ff 00 44 00 00 ff 30 00 00 7f 22 00 00 40
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


Iain

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
