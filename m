From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Aug 2011 13:31:46 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/4] hwmon: (pmbus) Don't return errors
Message-Id: <20110828153146.5305fe67@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314375545-18335-3-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1314375545-18335-3-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 26 Aug 2011 09:19:03 -0700, Guenter Roeck wrote:
> Driver remove functions have an error return value, but rarely return an error
> in practice. If a driver does return an error from its remove function, the
> driver won't be unloaded and is expected to stay alive.
> 
> pmbus_do_remove() is defined as returning an int, but always returns 0 (no
> error). Calling code passes that return value on to high level driver
> remove functions, but does not evaluate it and removes driver data even if
> pmbus_do_remove() returned an error (which it in practice never does). Even if
> this code could never cause a real problem, it is nevertheless conceptually
> wrong.
> 
> To reduce confusion and simplify the code, change pmbus_do_remove() to be a void
> function, and have PMBus client driver always return zero in its driver remove
> function.
> 
> Reported-by: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/pmbus/adm1275.c    |    5 ++---
>  drivers/hwmon/pmbus/lm25066.c    |    5 ++---
>  drivers/hwmon/pmbus/max16064.c   |    3 ++-
>  drivers/hwmon/pmbus/max34440.c   |    3 ++-
>  drivers/hwmon/pmbus/max8688.c    |    3 ++-
>  drivers/hwmon/pmbus/pmbus.c      |    5 ++---
>  drivers/hwmon/pmbus/pmbus.h      |    2 +-
>  drivers/hwmon/pmbus/pmbus_core.c |    3 +--
>  drivers/hwmon/pmbus/ucd9000.c    |    5 ++---
>  drivers/hwmon/pmbus/ucd9200.c    |    5 ++---
>  10 files changed, 18 insertions(+), 21 deletions(-)
> (...)

Seems reasonable, yes.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
