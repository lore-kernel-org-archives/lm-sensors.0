From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 31 Jan 2012 21:38:13 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: (hwmon-vid) Determine vrm during initialization, and add vrm
Message-Id: <20120131223813.4d03c023@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1327495414-6256-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 25 Jan 2012 04:43:34 -0800, Guenter Roeck wrote:
> The vrm value is system-wide and only needs to be calculated once. Do it when
> the module is loaded. Provide a module parameter to enable overwriting the
> default value in case it is wrong or can not be calculated.
> 
> Use the internal value when calculating the VID voltage; ignore the VRM
> parameter passed in vid_from_reg(). This will enable us to make the vrm
> attribute in individual drivers read-only or to drop it entirely.
> 
> Cc: Rudolf Marek <r.marek@assembler.cz>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/hwmon-vid.c |   56 +++++++++++++++++++++++++++++++++++++--------
>  1 files changed, 46 insertions(+), 10 deletions(-)
> 

I couldn't apply this one either...

> diff --git a/drivers/hwmon/hwmon-vid.c b/drivers/hwmon/hwmon-vid.c
> index 40b50b4..26dd0d7 100644
> --- a/drivers/hwmon/hwmon-vid.c
> +++ b/drivers/hwmon/hwmon-vid.c
> @@ -73,13 +73,20 @@
>   * http://www.intel.com/design/processor/applnots/313214.htm
>   */
>  
> +static ushort vrm;
> +module_param(vrm, ushort, S_IRUGO);

It might be convenient to make the value writable. For example this can
allow debugging the hwmon-vid code without breaking monitoring on the
running system.

> +MODULE_PARM_DESC(vrm, "VRM/VRD version, multiplied by 10");

This is no longer always true, as explained in doc/vid in the
lm-sensors source tree. This document should probably be updated and
moved to the kernel tree.

> +
>  /*
>   * vrm is the VRM/VRD document version multiplied by 10.
>   * val is the 4-bit or more VID code.
>   * Returned value is in mV to avoid floating point in the kernel.
>   * Some VID have some bits in uV scale, this is rounded to mV.
> + *
> + * Note: vrm is passed for legacy reasons to avoid API changes,
> + * but no longer used.

I don't see the point of preserving the API. We usually don't do that.
The API was wrong, you're fixing it, let's adjust all drivers
accordingly and be done with it.

>   */
> -int vid_from_reg(int val, u8 vrm)
> +int vid_from_reg(int val, u8 _vrm)
>  {
>  	int vid;
>  
> @@ -151,9 +158,6 @@ int vid_from_reg(int val, u8 vrm)
>  		val &= 0x7f;
>  		return val > 0x77 ? 0 : (1500000 - (val * 12500) + 500) / 1000;
>  	default:		/* report 0 for unknown */
> -		if (vrm)
> -			pr_warn("Requested unsupported VRM version (%u)\n",
> -				(unsigned int)vrm);
>  		return 0;
>  	}
>  }
> @@ -234,7 +238,7 @@ static struct vrm_model vrm_models[] = {
>   * + quirk for Eden ULV 500 MHz).
>   * Note: something similar might be needed for model A, I'm not sure.
>   */
> -static u8 get_via_model_d_vrm(void)
> +static u8 __init get_via_model_d_vrm(void)
>  {
>  	unsigned int vid, brand, dummy;
>  	static const char *brands[4] = {
> @@ -259,7 +263,7 @@ static u8 get_via_model_d_vrm(void)
>  	}
>  }
>  
> -static u8 find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
> +static u8 __init find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
>  {
>  	int i;
>  
> @@ -275,11 +279,24 @@ static u8 find_vrm(u8 family, u8 model, u8 stepping, u8 vendor)
>  	return 0;
>  }
>  
> -u8 vid_which_vrm(void)
> +static int __init vid_init(void)
>  {
>  	struct cpuinfo_x86 *c = &cpu_data(0);
>  	u8 vrm_ret;
>  
> +	if (vrm) {
> +		/*
> +		 * Validate vrm by calling vid_from_reg() with a known valid
> +		 * vid. If it returns a non-zero voltage, we know that vrm is
> +		 * valid. If the configured vrm is invalid, try to get it
> +		 * from CPU version data.
> +		 */
> +		if (vid_from_reg(2, vrm))

This is a little fragile... At the moment 2 is valid for all supported
VRM versions but this might not be the case for some future VRM version.

What about having vid_from_reg return -EINVAL or some such when it
doesn't know the VRM code passed by the user?

> +			return 0;
> +		pr_warn("Requested unsupported VRM version (%u)\n", vrm);
> +		vrm = 0;
> +	}

Let's fail the module load in that case.

> +
>  	if (c->x86 < 6)		/* Any CPU with family lower than 6 */
>  		return 0;	/* doesn't have VID and/or CPUID */

In that case (and also in the unknown VRM case below) the driver will
load and hwmon drivers will call vid_from_reg(). At the moment this
will return 0, which drivers will happily expose to user-space. Ideally
all drivers would handle this (or -EINVAL, see above) as an error and
NOT create the cpu[0-*]_vid attributes. This would be a separate patch
I guess.

>  
> @@ -288,19 +305,38 @@ u8 vid_which_vrm(void)
>  		vrm_ret = get_via_model_d_vrm();
>  	if (vrm_ret = 0)
>  		pr_info("Unknown VRM version of your x86 CPU\n");
> -	return vrm_ret;
> +
> +	vrm = vrm_ret;

Isn't this overriding the module parameter passed by the user?

> +
> +	return 0;
>  }
>  
>  /* and now for something completely different for the non-x86 world */
>  #else
> -u8 vid_which_vrm(void)
> +
> +static int __init vid_init(void)
>  {
> -	pr_info("Unknown VRM version of your CPU\n");
>  	return 0;
>  }
> +
>  #endif
> +
> +static void __exit vid_exit(void)
> +{
> +}

Do you really have to create that stub?

> +
> +u8 vid_which_vrm(void)
> +{
> +	if (!vrm)
> +		pr_info("Unknown VRM version of your CPU\n");
> +
> +	return vrm;
> +}
>  EXPORT_SYMBOL(vid_which_vrm);

There should be no user left for this function if you don't attempt to
preserve the API.

>  
> +module_init(vid_init);
> +module_exit(vid_exit);
> +
>  MODULE_AUTHOR("Rudolf Marek <r.marek@assembler.cz>");
>  
>  MODULE_DESCRIPTION("hwmon-vid driver");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
