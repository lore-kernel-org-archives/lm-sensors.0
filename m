From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 05 Mar 2009 15:47:30 +0000
Subject: Re: [lm-sensors] [PATCH] lm90: Support the MAX6648/6692 chips
Message-Id: <20090305154729.GL6550@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090302210106.GD6550@plum> <20090305152517.4e0b8983@hyperion.delvare>
In-Reply-To: <20090305152517.4e0b8983@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Thu, Mar 05, 2009 at 03:25:17PM +0100, Jean Delvare wrote:
> Hi Darrick
> I am confused. According to my notes, the MAX6648/MAX6692 is the same
> chip as the MAX6646/MAX6647/MAX6649 (same chip ID of 0x59), the only
> difference being the I2C address (0x4c for the MAX6646, 0x4e for the
> MAX6647 and 0x4d for the MAX6648/MAX6649/MAX6692). So the current code
> should _already_ detect your MAX6648 or MAX6692 as kind = max6646.

Heh, yep, it does.  I guess this patch has been sitting around long
enough to become obsolete, sorry for the unnecessary mail traffic.  I
guess we can drop this one.

> Can you please test the latest version of the sensors-detect script [1]
> and let me know if your chip is properly detected? If not, please
> provide a dump of your chip.

Just for fun, here's a dump of that chip (6648):

No size specified (using byte-data access)
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 15 1d 00 00 05 69 00 6e 05 05 05 05 05 05 05 05    ??..?i.n????????
10: e0 c0 c0 c0 c0 c0 c0 c0 00 91 91 91 91 91 91 91    ????????.???????
20: 91 0a 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
30: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
40: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
50: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
60: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
70: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
80: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
90: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
a0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
b0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
c0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
d0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
e0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86 86    ????????????????
f0: 86 86 86 86 86 86 86 86 86 86 86 86 86 86 4d 59    ??????????????MY

> [1] http://www.lm-sensors.org/svn/lm-sensors/trunk/prog/detect/sensors-detect

This also detects it properly.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
