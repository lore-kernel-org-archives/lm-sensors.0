From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Feb 2008 21:56:24 +0000
Subject: Re: [lm-sensors] [PATCH] coretemp: Add TjMax detection for mobile
Message-Id: <20080213225624.49daef35@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <478FE918.9030804@assembler.cz>
In-Reply-To: <478FE918.9030804@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ruik,

> Following patch will finally solve the detection of Intel Mobile CPUs which
> share same CPUID with Desktop/Server CPUs. We need this information to test
> some bit so we know if TjMax is 100C or 85C. Intel claims this works for mobiles
> only, respect that and set for desktops the TjMax to 100C. Intel provided some
> table on their wiki based on my chat with them at:
> http://softwarecommunity.intel.com/isn/Community/en-US/forums/30247249/ShowThread.aspx#30247249
> 
> The patch is totally untested, please check the patch, test and report ;)

I have a Mobile Core CPU (not Core 2) so I can only test that there
is no regression for this CPU family (and I confirm that.)

> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> Thanks,
> Rudolf
> 

Review: almost only style issues:

> Index: linux-2.6.24-rc7/drivers/hwmon/coretemp.c
> =================================> --- linux-2.6.24-rc7.orig/drivers/hwmon/coretemp.c	2008-01-18 00:19:34.899436907 +0100
> +++ linux-2.6.24-rc7/drivers/hwmon/coretemp.c	2008-01-18 00:32:26.147387823 +0100
> @@ -152,6 +152,57 @@
>  	return data;
>  }
>  
> +static int __devinit adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev) {
> +

Curly brace goes at the beginning of next line.

> +	/* The 100C is default for both mobile and non mobile CPUs */
> +
> +	int tjmax = 100000;
> +	int ismobile = 1;
> +	int err;
> +	u32 eax, edx;
> +
> +	/* Early chips have no MSR for TjMax */
> +
> +	if (((c->x86_model = 0xf) && (c->x86_mask < 4)) ||
> +	      (c->x86_model < 0xe)) {

This driver doesn't actually support any model < 0xe, so this test is
always false.

> +		ismobile = 0;
> +	}
> +
> +	if ((c->x86_model > 0xe) && (ismobile)) {
> +
> +		/* Now we can detect the mobile CPU using Intel provided table
> +		   http://softwarecommunity.intel.com/Wiki/Mobility/720.htm
> +		   For Core2 cores, check MSR 0x17, bit 28 1 = Mobile CPU
> +		*/
> +
> +		err = rdmsr_safe_on_cpu(id, 0x17, &eax, &edx);
> +		if (err) {
> +			dev_warn(dev,
> +				 "Unable to access MSR 0x17, assuming desktop"
> +				 " CPU\n");
> +			ismobile = 0;
> +		} else if (!(eax & 0x10000000)) {
> +				ismobile = 0;

Bad indentation.

> +		}
> +	}
> +
> +	if (ismobile) {
> +
> +		err = rdmsr_safe_on_cpu(id, 0xee, &eax, &edx);
> +		if (err) {
> +			dev_warn(dev,
> +				 "Unable to access MSR 0xEE, for Tjmax, left"
> +				 " at default");
> +		} else if (eax & 0x40000000) {
> +			tjmax = 85000;
> +		}
> +	} else  {

Doubled space.

> +		dev_warn(dev, "Using relative temperature scale!\n");
> +	}
> +
> +	return tjmax;
> +}
> +
>  static int __devinit coretemp_probe(struct platform_device *pdev)
>  {
>  	struct coretemp_data *data;
> @@ -168,8 +219,6 @@
>  	data->id = pdev->id;
>  	data->name = "coretemp";
>  	mutex_init(&data->update_lock);
> -	/* Tjmax default is 100 degrees C */
> -	data->tjmax = 100000;
>  
>  	/* test if we can access the THERM_STATUS MSR */
>  	err = rdmsr_safe_on_cpu(data->id, MSR_IA32_THERM_STATUS, &eax, &edx);
> @@ -196,36 +245,7 @@
>  		}
>  	}
>  
> -	/* Some processors have Tjmax 85 following magic should detect it
> -	   Intel won't disclose the information without signed NDA, but
> -	   individuals cannot sign it. Catch(ed) 22.
> -	*/
> -
> -	if (((c->x86_model = 0xf) && (c->x86_mask > 3)) ||
> -		(c->x86_model = 0xe))  {
> -		err = rdmsr_safe_on_cpu(data->id, 0xee, &eax, &edx);
> -		if (err) {
> -			dev_warn(&pdev->dev,
> -				 "Unable to access MSR 0xEE, Tjmax left at %d "
> -				 "degrees C\n", data->tjmax/1000);
> -		} else if (eax & 0x40000000) {
> -			data->tjmax = 85000;
> -		}
> -	}
> -
> -	/* Intel says that above should not work for desktop Core2 processors,
> -	   but it seems to work. There is no other way how get the absolute
> -	   readings. Warn the user about this. First check if are desktop,
> -	   bit 50 of MSR_IA32_PLATFORM_ID should be 0.
> -	*/
> -
> -	rdmsr_safe_on_cpu(data->id, MSR_IA32_PLATFORM_ID, &eax, &edx);
> -
> -	if ((c->x86_model = 0xf) && (!(edx & 0x00040000))) {
> -		dev_warn(&pdev->dev, "Using undocumented features, absolute "
> -			 "temperature might be wrong!\n");
> -	}
> -
> +	data->tjmax = adjust_tjmax(c, data->id, &pdev->dev);
>  	platform_set_drvdata(pdev, data);
>  
>  	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
