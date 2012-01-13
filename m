From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 13 Jan 2012 15:13:36 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: Add support for extra fan attributes
Message-Id: <20120113151336.GC23019@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120113155100.1e081f29@endymion.delvare>
In-Reply-To: <20120113155100.1e081f29@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jan 13, 2012 at 09:51:00AM -0500, Jean Delvare wrote:
> Add support for fan[1-*]_max, fan[1-*]_min_alarm and fan[1-*]_max_alarm
> attributes. These are defined in the standard sysfs interface for quite
> some time, and at least three drivers (max6650, lm63 and applesmc)
> implement them so we should support them.
> ---
>  doc/libsensors-API.txt |    3 +++
>  lib/sensors.h          |    3 +++
>  lib/sysfs.c            |    3 +++
>  prog/sensors/chips.c   |   38 +++++++++++++++++++++++++-------------
>  4 files changed, 34 insertions(+), 13 deletions(-)
> 
Looks good.

Maybe I should try to re-do that using the table based generic code. Wonder why I didn't earlier.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
