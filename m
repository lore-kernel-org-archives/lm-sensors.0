From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 16:17:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Use helper functions to set and get
Message-Id: <20110406161722.GC25724@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110406175813.415fa480@endymion.delvare>
In-Reply-To: <20110406175813.415fa480@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 06, 2011 at 11:58:13AM -0400, Jean Delvare wrote:
> Use helper functions to set and get driver data. This is more elegant.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> ---
>  drivers/hwmon/adcxx.c       |   16 ++++++++--------
>  drivers/hwmon/ibmaem.c      |   10 +++++-----
>  drivers/hwmon/k10temp.c     |    6 +++---
>  drivers/hwmon/k8temp.c      |    8 ++++----
>  drivers/hwmon/lm70.c        |   10 +++++-----
>  drivers/hwmon/ultra45_env.c |    4 ++--
>  6 files changed, 27 insertions(+), 27 deletions(-)
> 
Nice cleanup.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
