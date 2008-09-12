From: Marco Chiappero <marco@absence.it>
Date: Fri, 12 Sep 2008 11:03:29 +0000
Subject: Re: [lm-sensors] New winbond chip: W83667HG
Message-Id: <48CA4C81.10203@absence.it>
List-Id: <lm-sensors.vger.kernel.org>
References: <200807072054.10321.phhusson@free.fr>
In-Reply-To: <200807072054.10321.phhusson@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare ha scritto:
> Hi Marco,
> 
> The correct syntax is:
> isadump -k 0x87,0x87 0x2e 0x2f

Ok, thanks. I have never used isadump before so I just cutted and paisted.
Here the output:

root@etna:~# isadump -k 0x87,0x87 0x2e 0x2f
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x2e and data register 0x2f.
Continue? [Y/n]
      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff 00 ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: a5 13 ff 00 44 00 00 ff 40 08 00 7f 22 00 00 40
30: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
60: 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
70: 00 ff ff ff 02 ff ff ff ff ff ff ff ff ff ff ff
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
f0: 0e 00 ff ff 00 00 ff ff ff ff ff ff ff ff ff ff

Please reply if you need some other informations.


Marco

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
