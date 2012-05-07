From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Mon, 07 May 2012 10:59:48 +0000
Subject: Re: [lm-sensors] [PATCH, v3] hwmon: coretemp: use list instead of fixed size array for temp
Message-Id: <4D68720C2E767A4AA6A8796D42C8EB591184C1@BGSMSX102.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1336386848-31041-1-git-send-email-kirill.shutemov@linux.intel.com>
In-Reply-To: <1336386848-31041-1-git-send-email-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Andi Kleen <ak@linux.intel.com>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi,


> -----Original Message-----
> From: Kirill A. Shutemov [mailto:kirill.shutemov@linux.intel.com]
> Sent: Monday, May 07, 2012 4:04 PM
> To: Yu, Fenghua; Guenter Roeck; R, Durgadoss
> Cc: Andi Kleen; Jean Delvare; lm-sensors@lm-sensors.org; linux-
> kernel@vger.kernel.org; Kirill A. Shutemov
> Subject: [PATCH, v3] hwmon: coretemp: use list instead of fixed size array for
> temp data
> 
> From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> 
> Let's rework code to allow arbitrary number of cores on a CPU, not
> limited by hardcoded array size.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  v3:
>    - drop redundant refcounting and checks;
>  v2:
>    - fix NULL pointer dereference. Thanks to R, Durgadoss;
>    - use mutex instead of spinlock for list locking.
> ---
>  drivers/hwmon/coretemp.c |  120 ++++++++++++++++++++++++++++-----------
> ------
>  1 files changed, 75 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index b9d5123..fa082d5 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -36,6 +36,8 @@
>  #include <linux/cpu.h>
>  #include <linux/pci.h>
>  #include <linux/smp.h>
> +#include <linux/list.h>
> +#include <linux/kref.h>

I think we don't need to include kref.h now :-)

BTW, at some places, looks like we are using 'tdata' obtained from get_temp_data,
without checking for NULL values. Other than that, looks Ok for me.

Acked-by: Durgadoss R <durgadoss.r@intel.com>

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
