From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Call for 2.9.0
Message-Id: <20041228135237.44db83da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself (again):

> I just verified compatibility with old kernels back to 2.4.10, and
> commited a couple trivial fixes for this. 2.4.9 is no longer
> supported, as it would require more work than is worth (most notably
> because MODULE_LICENSE doesn't exist back there).

I was not quite correct here. MODULE_LICENSE is properly handled from a
long time through a quirk in i2c.h. i2c 2.9.0 will actually be
2.4.9-compatible. However, lm_sensors 2.0 won't and we probably don't
want it to be. 2.4.9 not only lacks MODULE_LICENSE but also snprintf,
min_t/max_t and a couple other functions/macros used in various
lm_sensors drivers. I see little point in supporting 2.4.9 in i2c and
only 2.4.10 in lm_sensors, which is why I believe we can happily go with
2.4.10 for both. Only a fool would use such old kernels today anyway.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
