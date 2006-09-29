From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Sep 2006 11:27:15 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20060929132715.a0247097.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans,

> With the double 0x87 key I get the following results:
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff 00 ff ff ff ff 05 ff ff ff ff ff ff ff ff
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 20: 05 41 10 19 34 00 00 7e 70 ff 44 a0 07 0a 00 00
> 30: 01 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 60: 00 60 ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 70: 01 ff 0c ff ff ff ff ff ff ff ff ff ff ff ff ff
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> f0: 83 00 f0 ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> > Now I'd like to understand why sensors-detect didn't find the logical
> > device number. 
> 
> Forgot to copy paste the last line:
> (logical device 4 has address 0x295, could be sensors)

Ahhhh, so it DID work perfectly! Good news.

Now the next step is to add proper detection to sensors-detect. Can you
please provide a patch? It should be as easy as adding an entry into
@superio_ids. devid is the value at 0x20 in the dump above, so 0x0541
for this Epox chip. Set the driver to "to-be-written" until the driver
has been written.

Thanks,
-- 
Jean Delvare

