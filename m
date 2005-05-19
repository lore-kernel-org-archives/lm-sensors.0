From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: Call for 2.9.0
Message-Id: <41D185AB.6020004@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Unless these same limitations apply to a particular series of kernel 
releases from Red Hat.  Like it or not, there are comercial software 
packages that still are only supported on relatively ancient distro's 
like Red Hat 7.1 and 7.3.

The good news is that the last Red Hat 7.x errata kernel was pretty 
recent.  Let me check...

Hmmm..  OK...

Red Hat 7.1 was released with a 2.4.9 kernel base but the most recent 
errata kernel I see is 2.4.20-28.7
Red Hat 7.3 was released with a 2.4.18 kernel base and the most recent 
errata kernel is 2.4.20-28.7

Red Hat 8, 9 and so on are of course more recent.

Unfortunately, Red Hat 2.1 Advanced Server uses a derivative of the 7.1 
kernel: 2.4.9-e.24 (in Update 2).

So if we drop 2.4.9, then I think we need to test the Red Hat Advanced 
Server kernel.  (Which I will volunteer to do...)  Depending on the 
result of that test, I would suggest that we mention what distro kernels 
are not supported (*initial* 7.1 kernel, etc.).

:v)

Jean Delvare wrote:

>Quoting myself (again):
>
>  
>
>>I just verified compatibility with old kernels back to 2.4.10, and
>>commited a couple trivial fixes for this. 2.4.9 is no longer
>>supported, as it would require more work than is worth (most notably
>>because MODULE_LICENSE doesn't exist back there).
>>    
>>
>
>I was not quite correct here. MODULE_LICENSE is properly handled from a
>long time through a quirk in i2c.h. i2c 2.9.0 will actually be
>2.4.9-compatible. However, lm_sensors 2.0 won't and we probably don't
>want it to be. 2.4.9 not only lacks MODULE_LICENSE but also snprintf,
>min_t/max_t and a couple other functions/macros used in various
>lm_sensors drivers. I see little point in supporting 2.4.9 in i2c and
>only 2.4.10 in lm_sensors, which is why I believe we can happily go with
>2.4.10 for both. Only a fool would use such old kernels today anyway.
>
>Thanks,
>  
>
