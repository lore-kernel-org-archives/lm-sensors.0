From: Huaxu Wan <huaxu.wan@linux.intel.com>
Date: Mon, 10 May 2010 03:09:17 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (coretemp) Get TjMax value from
Message-Id: <20100510030917.GB9181@owl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100507095945.GB12190@owl>
 <4BE415B8.1010400@osadl.org>
In-Reply-To: <4BE415B8.1010400@osadl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Carsten Emde <Carsten.Emde@osadl.org>
Cc: Huaxu Wan <huaxu.wan@linux.intel.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Huaxu Wan <huaxu.wan@intel.com>

On 15:29 Fri 07 May, Carsten Emde wrote:

> +	err = rdmsr_safe_on_cpu(id, MSR_IA32_TEMPERATURE_TARGET, &eax, &edx);
> +	if (err)
> +		dev_warn(dev, "Unable to read TjMax from CPU.\n");
> +	else {
> +		val = (eax >> 16) & 0xff;
> +		if (val > 80 && val < 120) {
> +			dev_info(dev, "TjMax is %dC.\n", val);
> +			return val * 1000;
> +		} else {
> +			dev_warn(dev, "TjMax of %dC not plausible,"
> +			    " using 100C instead." , val);
> +			return 100000;
> +		}
> +	}

The CPU, in the following case switch, may return no err at the above rdmsr. The
val is 0 with CPU model 0x0f in my test. The function should not return when
(val > 80 && val < 120) is false. 

> +
> +	/*
> +	 * An assumption is made for early CPUs and unreadable MSR.
> +	 * NOTE: the given value may not be correct.
> +	 */
> +	switch (c->x86_model) {
> +	case 0x0e:
> +	case 0x0f:
> +	case 0x16:
> +	case 0x1a:
> +		dev_warn(dev, "TjMax is assumed as 100C!\n");
> +		return 100000;
> +		break;
> +	case 0x17:
> +	case 0x1c: /* Atom CPUs */
> +		return adjust_tjmax(c, id, dev);
> +		break;
> +	default:
> +		dev_warn(dev, "CPU (model=0x%x) is not supported yet,"
> +		    " using default TjMax of 100C.\n", c->x86_model);
> +		return 100000;
> +	}
> +}

-- 
Thanks
Huaxu

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
