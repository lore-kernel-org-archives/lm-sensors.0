From: t.j.fritz@gmx.de (Tobias Fritz)
Date: Thu, 07 Dec 2006 12:54:12 +0000
Subject: [lm-sensors] fancontrol with IT8705F
Message-Id: <200612071354.12240.t.j.fritz@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <4576F2F4.9050200@gmx.de>
In-Reply-To: <4576F2F4.9050200@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thanks for your reply. I rewrote fancontrol now and it works ok. But I'd still 
be interested in a better solution. I'll contact the author of speedfan to 
see if he really got it to work better or just mapped the 0-10 values to his 
0-100% settings (if there are just 10 different speeds I can set my fan to I 
can live very well with the fancontrol hack. However if it is possible to set 
it to more values it would be nice because right now it goes from 1500 RPM 
directly to 2000 and then to 2200 and doesn't change much more after that)

> please provide
> the output of "isadump 0x295 0x296". Register 0x14 has bits to change
> the PWM frequency. Another bit in this register could also affect your
> ability to control the fan speed (PWM minimum duty select.)

Output of the isadump:

? ? ?0 ?1 ?2 ?3 ?4 ?5 ?6 ?7 ?8 ?9 ?a ?b ?c ?d ?e ?f
00: 19 10 ff 07 37 ff 07 37 ff 07 1a 09 09 ff ff ff
10: ff ff ff 72 87 00 01 00 00 00 00 00 00 00 00 00
20: 69 00 cf b1 be 00 00 af ff 2d 1b ff ff ff ff ff
30: ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff
40: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
50: ff 18 7f 7f 7f ff ff ff 90 56 fb 12 00 00 00 00
60: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
70: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff
80: 19 10 00 00 37 ff 07 37 ff 07 1a 09 09 ff ff ff
90: ff ff ff 72 87 00 01 00 00 00 00 00 00 00 00 00
a0: 69 00 cf b1 be 00 00 af ff 2d 1b ff ff ff ff ff
b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ef ff ff
c0: ff ff ff ff ff ff ff ff 2d ff ff ff ff ff ff ff
d0: ff 18 7f 7f 7f ff ff ff 90 56 fb 12 00 00 00 00
e0: 7f 7f 7f 7f 7f 00 00 00 7f 7f 7f 7f 7f 00 00 00
f0: 7f 7f 7f 7f 00 00 00 00 ff ff ff ff ff ff ff ff

I'll write more when I have a reply from the speedfan author.

Thanks again,

Tobias

