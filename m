From: "Jan Beulich" <JBeulich@novell.com>
Date: Fri, 03 Sep 2010 07:08:37 +0000
Subject: Re: [lm-sensors] [PATCH] x86/hwmon: fix configuration and
Message-Id: <4C80BB1502000078000141D7@vpn.id2.novell.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4C7FB8370200007800013F40@vpn.id2.novell.com>
 <20100902212505.GA31811@fenghua-desk.sc.intel.com>
In-Reply-To: <20100902212505.GA31811@fenghua-desk.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Fenghua Yu <fenghua.yu@intel.com>
Cc: "r.marek@assembler.cz" <r.marek@assembler.cz>, "mingo@elte.hu" <mingo@elte.hu>, "tglx@linutronix.de" <tglx@linutronix.de>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>

>>> On 02.09.10 at 23:25, Fenghua Yu <fenghua.yu@intel.com> wrote:
>> --- linux-2.6.36-rc3/arch/x86/include/asm/cpufeature.h
>> +++ 2.6.36-rc3-x86-hwmon/arch/x86/include/asm/cpufeature.h
>> @@ -168,6 +168,7 @@
>>  #define X86_FEATURE_XSAVEOPT	(7*32+ 4) /* Optimized Xsave */
>>  #define X86_FEATURE_PLN		(7*32+ 5) /* Intel Power Limit Notification */
>>  #define X86_FEATURE_PTS		(7*32+ 6) /* Intel Package Thermal Status */
>> +#define X86_FEATURE_DTS		(7*32+31) /* Digital Thermal Sensor */
> 
> Is there any paticular reason to chose 7*32+31 instead of 7*32+7?

Oh, right, I actually wanted to changes this before final submission
(I coded it this way locally to avoid eventual collisions until I would
get to submit this).

>> --- linux-2.6.36-rc3/drivers/hwmon/coretemp.c
>> +++ 2.6.36-rc3-x86-hwmon/drivers/hwmon/coretemp.c
>> @@ -423,9 +423,18 @@ static int __cpuinit coretemp_device_add
>>  	int err;
>>  	struct platform_device *pdev;
>>  	struct pdev_entry *pdev_entry;
>> -#ifdef CONFIG_SMP
>>  	struct cpuinfo_x86 *c = &cpu_data(cpu);
>> -#endif
>> +
>> +	/*
>> +	 * CPUID.06H.EAX[0] indicates whether the CPU has thermal
>> +	 * sensors. We check this bit only, all the early CPUs
>> +	 * without thermal sensors will be filtered out.
>> +	 */
>> +	if (!cpu_has(c, X86_FEATURE_DTS)) {
>> +		printk(KERN_INFO DRVNAME ": CPU (model=0x%x)"
>> +		       " has no thermal sensor.\n", c->x86_model);
>> +		return 0;
> 
> Return an error (e.g. -ENODEV) could be better because there is no device for
> this driver. Then caller may handle this error accordingly (no caller 
> handles
> the error currently, though).

No, the intention of the change is for the code to remain logically
the same as it was - since the failed check previously only resulted
in a message getting printed, returning an error indication
(irrespective of there not being a check at the call sites) didn't
seem right to me.

Jan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
