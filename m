From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E23C9@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK, here it is,

# prog/dump/isadump 0x295 0x296
  WARNING! Running this program can cause system crashes, data loss and worse!
  I will probe address register 0x0295 and data register 0x0296.
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
20: 5a 6f cd b7 cb cb 99 22 ff ff 35 58 50 58 50 d8
30: c4 c3 b0 d9 b2 31 15 3b 31 3c 7f 6d ba e1 00 00
40: 01 00 10 00 00 00 00 5e 1f 02 89 c4 41 95 00 a3
50: ff ff 00 ff ff ff 00 00 21 60 10 13 19 0f ff 05
60: 5a 6f cd b7 cb cb 99 22 ff ff 35 58 50 58 50 d8
70: c4 c3 b0 d9 b2 31 15 3b 31 3c 7f 6d ba e1 00 00
80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
a0: 5a 6f cd b7 cb cb 99 22 ff ff 35 58 50 58 50 d8
b0: c4 c3 b0 d9 b2 31 15 3b 31 3c 7f 6d ba e1 00 00
c0: 01 00 00 00 00 00 00 5e 1f 02 89 c4 41 95 00 a3
d0: ff ff 80 ff ff ff 00 00 21 60 10 13 19 0f ff 05
e0: 5a 6f cd b7 cb cb 99 22 ff ff 35 58 50 58 50 d8
f0: c4 c3 b0 d9 b2 31 15 3b 31 3c 7f 6d ba e1 00 00

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Friday, October 24, 2003 12:06 PM
> To: Marc Rieffel
> Cc: sensors@Stimpy.netroedge.com
> Subject: Re: Issues with lm_sensors on Intel SE7501cw2
> 
> 
> 
> > How do I do a dump of the chip?
> 
> I think you have to run "prog/sensors/isadump 0x295 0x296" after
> unloading any chip driver that might be using that range (that is,
> w83627hf).
> 
> Thanks.
> 
> -- 
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
> 
