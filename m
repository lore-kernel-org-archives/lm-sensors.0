From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 20 Aug 2010 06:53:02 +0000
Subject: Re: [lm-sensors] [PATCH] MAINTAINERS: hwmon/coretemp: Change
Message-Id: <20100820085302.5d29d2e3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1282238896-23026-1-git-send-email-fenghua.yu@intel.com>
In-Reply-To: <1282238896-23026-1-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Rudolf Marek <r.marek@assembler.cz>, Huaxu Wan <huaxu.wan@intel.com>, H Peter Anvin <hpa@zytor.com>, Guenter Roeck <guenter.roeck@ericsson.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, Fenghua Yu <fenghua.yu@intel.com>

Hi Fenghua,

On Thu, 19 Aug 2010 10:28:16 -0700, Fenghua Yu wrote:
> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Huaxu and Rudolf want me to be the hwmon coretemp driver maintainer and remove
> their names from the coretemp maintainer entry.

Thanks for stepping in! The coretemp driver definitely needs some
love.

> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Acked-by: Rudolf Marek <r.marek@assembler.cz>
> Acked-by: Huaxu Wan <huaxu.wan@intel.com>
> ---
>  MAINTAINERS |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b5b8baa..ff0cd1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1665,8 +1665,7 @@ F:	kernel/cgroup*
>  F:	mm/*cgroup*
>  
>  CORETEMP HARDWARE MONITORING DRIVER
> -M:	Rudolf Marek <r.marek@assembler.cz>
> -M:	Huaxu Wan <huaxu.wan@intel.com>
> +M:	Fenghua Yu <fenghua.yu@intel.com>
>  L:	lm-sensors@lm-sensors.org
>  S:	Maintained
>  F:	Documentation/hwmon/coretemp

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
