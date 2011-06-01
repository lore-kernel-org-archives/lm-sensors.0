From: "Yu, Fenghua" <fenghua.yu@intel.com>
Date: Wed, 01 Jun 2011 18:32:44 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (coretemp) Further relax
Message-Id: <493994B35A117E4F832F97C4719C4C04011E3427A6@orsmsx505.amr.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Guenter Roeck [mailto:guenter.roeck@ericsson.com]
> Sent: Wednesday, June 01, 2011 11:09 AM
> To: lm-sensors@lm-sensors.org
> Cc: Guenter Roeck; Carsten Emde; Yu, Fenghua; Jean Delvare
> Subject: [PATCH] hwmon: (coretemp) Further relax temperature range
> checks
> 
> Further relax temperature range checks after reading the
> IA32_TEMPERATURE_TARGET
> register. If the register returns a value other than 0 in bits 16..32,
> assume
> that the returned value is correct.
> 
> This change applies to both packet and core temperature limits.
> 
> Cc: Carsten Emde <C.Emde@osadl.org>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/coretemp.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index 1680977..85e9379 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -296,7 +296,7 @@ static int get_tjmax(struct cpuinfo_x86 *c, u32 id,
> struct device *dev)
>  		 * If the TjMax is not plausible, an assumption
>  		 * will be used
>  		 */
> -		if (val >= 70 && val <= 125) {
> +		if (val) {
>  			dev_info(dev, "TjMax is %d C.\n", val);
>  			return val * 1000;
>  		}
> @@ -326,7 +326,7 @@ static int get_pkg_tjmax(unsigned int cpu, struct
> device *dev)
>  	err = rdmsr_safe_on_cpu(cpu, MSR_IA32_TEMPERATURE_TARGET, &eax,
> &edx);
>  	if (!err) {
>  		val = (eax >> 16) & 0xff;
> -		if (val > 80 && val < 120)
> +		if (val)
>  			return val * 1000;
>  	}
>  	dev_warn(dev, "Unable to read Pkg-TjMax from CPU:%u\n", cpu);
> --
> 1.7.3.1

Acked-by: Fenghua Yu <fenghua.yu@intel.com>


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
