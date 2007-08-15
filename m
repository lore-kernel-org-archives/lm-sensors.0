From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 15 Aug 2007 19:28:58 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070815212858.352b6903@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Wed, 15 Aug 2007 17:32:03 +0200, Christian Hohnstaedt wrote:
>   - replace differing temperature variable types by long
>   - use strtol() instead of strtoul() for conversion

Note: I've taken a look at the simple_strtol implementation and found
that it is calling simple_strtoul(), and that simple_strtoul doesn't
handle overflows. After all these functions are called "simple" for a
reason... This means that there's little point in being very strict in
the driver code on that front.

Still, I like this patch, that's a nice cleanup.

> Signed-off-by: Christian Hohnstaedt <chohnstaedt@innominate.com>
> ---
>  drivers/hwmon/ad7418.c    |    2 +-
>  drivers/hwmon/asb100.c    |    4 ++--
>  drivers/hwmon/ds1621.c    |    2 +-
>  drivers/hwmon/lm75.c      |    2 +-
>  drivers/hwmon/lm75.h      |    2 +-
>  drivers/hwmon/w83627ehf.c |    2 +-
>  drivers/hwmon/w83627hf.c  |    6 +++---
>  drivers/hwmon/w83781d.c   |    2 +-
>  8 files changed, 11 insertions(+), 11 deletions(-)

Test results:

ds1261: all OK
w83627ehf: temp1 not OK (can't write negative limits)
w83627hf: all OK
w83781d: all OK

Please fix the w83627ehf temp1 case and resubmit.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
