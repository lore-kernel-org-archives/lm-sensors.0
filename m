From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 28 Sep 2006 21:39:20 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20060928233920.852121d7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > isadump -k 0x87,0x87 0x2e 0x2f
> 
> Try this
> 
> > or try -k 0x55
> 
> isadump -k 0x55 0x2e 0x2f
> 
> Or this ;)
> 
> > SO please try to "unlock" the superio first. I would bet that the key -k
> > 0x55
> > will work but check it out yourself ;)
> > 
> > ruik:/tmp# isadump -k 0x87,0x87 0x2e 0x2f 2
> > WARNING! Running this program can cause system crashes, data loss and worse!
> > I will probe address register 0x2e and data register 0x2f.
> > Probing bank 2 using bank register 0x07.
> > Continue? [Y/n] y
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> > 00: ff ff ff ff ff ff ff 02 ff ff ff ff ff ff ff ff
> > 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 20: 88 63 ff 00 80 00 00 ff 50 04 01 00 f0 21 00 ff
> > 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 60: 03 f8 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 70: 04 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> > f0: 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> 
> The unlocked suoperIO looks like this. If you manage to see something like this
> then proceed down to check what logical device the chip resides. Just switch do
> dumps with
> 
> > ruik:/tmp# isadump -k 0x87,0x87 0x2e 0x2f 2
> 
> and change the last number from 0 1? to 15
> 
> and check the bytes at 60: you should see the 02 90 or 02 95

Or you could simply try the version of sensors-detect which comes with
lm_sensors 2.10.1, which would detect automatically which key is needed
to unlock the Super-I/O, and which logical device corresponds to
hardware monitoring.

I wrote this code for a reason...

Thanks,
-- 
Jean Delvare

