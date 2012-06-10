From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jun 2012 18:24:13 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (coretemp) Document TjMax for Atom Z2460 CPU
Message-Id: <20120610182413.GA11896@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1338958116-6205-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1338958116-6205-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jun 06, 2012 at 12:48:34AM -0400, Guenter Roeck wrote:
> TjMax for Atom Z2460 (Medfield) is 90 degrees C per information from Intel.
> Document it.
> 
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: "R, Durgadoss" <durgadoss.r@intel.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/coretemp |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
> 
Hi Jean,

any comments on this patch series ?

Thanks,
Guenter

> diff --git a/Documentation/hwmon/coretemp b/Documentation/hwmon/coretemp
> index 3d7f2d7..f6aed440 100644
> --- a/Documentation/hwmon/coretemp
> +++ b/Documentation/hwmon/coretemp
> @@ -66,6 +66,9 @@ Process		Processor					TjMax(C)
>  		U3400						105
>  		P4505/P4500 					90
>  
> +32nm		Atom Processors
> +		Z2460						90
> +
>  45nm		Xeon Processors 5400 Quad-Core
>  		X5492, X5482, X5472, X5470, X5460, X5450	85
>  		E5472, E5462, E5450/40/30/20/10/05		85
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
