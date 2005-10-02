From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 02 Oct 2005 22:57:55 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <20051002225724.0b9de179.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

> > Hm, that's odd. The device is supposed not to decode offsets 0-4 and 7.
> > I checked on my own LM78 and it actually doesn't (they all return
> > 0xff). I suspect that you have another device mapped in the same I/O
> > region, maybe in such a way that there is no major conflict, but it
> > still makes the LM78 very hard to detect.
> 
> Hmm, so an ISA NIC at 0x280 is probably a bad idea?  Wasn't showing 
> in /proc/ioports as the driver wasn't loaded.  Sorry about that, me 
> not think of it.
> 
> Removing the offending NIC, we get:
> 
> root@silly:~# isadump -y -f 0x290 16
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff 40 01 ff ff ff ff ff ff ff ff ff

OK, that explains it all ! Thanks for the info, I'll update the support
ticket.

-- 
Jean Delvare
