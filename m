From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 21:12:21 +0000
Subject: Re: [lm-sensors] [RFC PATCH 1/3] hwmon: (hwmon-vid) Add new entries to VRM model table
Message-Id: <20120131221221.2dfe18a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 25 Jan 2012 04:43:32 -0800, Guenter Roeck wrote:
> The VRM model table was missing several Intel CPUs, resulting in wrong VRM table
> entries to be used for many recent CPUs. Update it. Also, use values from
> struct cpuinfo_x86 to retrieve CPU model information instead of re-calculating
> it locally.
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/hwmon-vid.c |  103 ++++++++++++++++++++++-----------------------
>  1 files changed, 50 insertions(+), 53 deletions(-)

Very nice cleanup, I like it. Two comments:

> 
> diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
> index 4029ac6..5ec5e37 100644
> --- a/drivers/hwmon/hwmon-vid.c
> +++ b/drivers/hwmon/hwmon-vid.c
> @@ -166,9 +166,10 @@ int vid_from_reg(int val, u8 vrm)
>  
>  struct vrm_model {
>  	u8 vendor;
> -	u8 eff_family;
> -	u8 eff_model;
> -	u8 eff_stepping;
> +	u8 family;
> +	u8 model_from;
> +	u8 model_to;
> +	u8 stepping;

It might make sense to name that one stepping_to for consistency.

>  	u8 vrm_type;
>  };
>  (...)
> @@ -272,21 +278,12 @@ static u8 find_vrm(u8 eff_family, u8 eff_model, u8 eff_stepping, u8 vendor)
>  u8 vid_which_vrm(void)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(0);
> -	u32 eax;
> -	u8 eff_family, eff_model, eff_stepping, vrm_ret;
> +	u8 vrm_ret;
>  
>  	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
>  		return 0;	/* doesn't have VID and/or CPUID */

The reference to CPUID could be removed as you no longer call
cpuid_eax().

>  
> -	eax = cpuid_eax(1);
> -	eff_family = ((eax & 0x00000F00)>>8);
> -	eff_model  = ((eax & 0x000000F0)>>4);
> -	eff_stepping = eax & 0xF;
> -	if (eff_family = 0xF) {	/* use extended model & family */
> -		eff_family += ((eax & 0x00F00000)>>20);
> -		eff_model += ((eax & 0x000F0000)>>16)<<4;
> -	}
> -	vrm_ret = find_vrm(eff_family, eff_model, eff_stepping, c->x86_vendor);
> +	vrm_ret = find_vrm(c->x86, c->x86_model, c->x86_mask, c->x86_vendor);
>  	if (vrm_ret = 134)
>  		vrm_ret = get_via_model_d_vrm();
>  	if (vrm_ret = 0)

Assuming you'll fix the above:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
