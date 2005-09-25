From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 25 Sep 2005 20:09:32 +0000
Subject: [lm-sensors] lm78 on ep-61lxa-m not detected (#2042)
Message-Id: <20050925200859.512dacc4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
In-Reply-To: <lcdlh19r75vv5je60he27tap49ggekrvfu@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Grant,

Sorry for the delay,

> # isadump -y -f 0x290 16
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: 01 ff ff 00 00 00 1a 80 ff ff ff ff 00 00 00 00

Hm, that's odd. The device is supposed not to decode offsets 0-4 and 7.
I checked on my own LM78 and it actually doesn't (they all return
0xff). I suspect that you have another device mapped in the same I/O
region, maybe in such a way that there is no major conflict, but it
still makes the LM78 very hard to detect.

So I finally do not think this would be reasonable to weaken the LM78
detection for just one case. This would put other systems at risk
(reading from the LM78 requires writing arbitrary values to port
0x295). Please use the force module parameter to workaround the problem.

-- 
Jean Delvare
