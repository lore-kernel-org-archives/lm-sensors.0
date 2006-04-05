From: jo.lodewyckx@edpnet.be (Jo Lodewyckx)
Date: Wed, 05 Apr 2006 23:35:32 +0000
Subject: [lm-sensors] ali1563 problems
Message-Id: <000001c65909$a4e226a0$937ba8c0@genesis>
List-Id: <lm-sensors.vger.kernel.org>
References: <000001c657ef$bd81d2c0$937ba8c0@genesis>
In-Reply-To: <000001c657ef$bd81d2c0$937ba8c0@genesis>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

Here's the isadump:



regawebdev jo # isadump 0x295 0x296
WARNING! Running this program can cause system crashes, data loss and worse!
I will probe address register 0x295 and data register 0x296.
Continue? [Y/n]
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 5b 5c cd bb c7 c7 c8 15 38 35 ff ff 00 ff 00 ed
30: b0 52 3d e1 4b 50 8c 42 79 33 78 4e 3c ff 00 00
40: 01 08 06 00 00 00 00 ff 2d 03 01 44 08 15 80 5c
50: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 00 ff 05
60: 5b 5c cd bb c7 c7 c8 15 38 35 ff ff 00 ff 00 ed
70: b0 52 3d e1 4b 50 8c 42 79 33 78 4e 3c ff 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 5b 5c cd bb c7 c7 c8 15 38 35 ff ff 00 ff 00 ed
b0: b0 52 3d e1 4b 50 8c 42 79 33 78 4e 3c ff 00 00
c0: 01 00 00 00 00 00 00 ff 2d 03 01 44 08 15 80 5c
d0: ff ff 00 ff ff ff 00 80 21 70 ff ff 11 00 ff 05
e0: 5b 5c cd bb c7 c7 c8 15 38 35 ff ff 00 ff 00 ed
f0: b0 52 3d e1 4b 50 8c 42 79 33 78 4e 3c ff 00 00

Regards,

Jo


-----Original Message-----
From: Rudolf Marek [mailto:r.marek at sh.cvut.cz] 
Sent: woensdag 5 april 2006 9:51
To: Jo Lodewyckx
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] ali1563 problems


> Do you want to scan the ISA bus? (YES/no):
> 
> Probing for `Winbond W83627HF'
> Trying address 0x0290... Success!
> (confidence 8, driver `w83781d')
>
> Some Super I/O chips may also contain sensors. Super I/O probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this. This is usually safe though.
> 
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for `Winbond W83627HF Super IO Sensors'
> Success... found at address 0x0290/

Please can you provide dump of:

isadump 0x295 0x296

Thanks,

Regards
Rudolf



