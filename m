From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 14 Dec 2010 10:18:43 +0000
Subject: Re: [lm-sensors] Patch[1/1] Adding Core Thermal Threshold Support
Message-Id: <D6D887BA8C9DFF48B5233887EF04654105C1109391@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654105C1077008@bgsmsx502.gar.corp.intel.com>
 <4D059217.9070905@linux.intel.com>
In-Reply-To: <4D059217.9070905@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Chen Gong <gong.chen@linux.intel.com>
Cc: "Yu, Fenghua" <fenghua.yu@intel.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "lenb@kernel.org" <lenb@kernel.org>

Hi Gong,

> > +	/* Mask the thermal vector in the lapic */
> > +	l = apic_read(APIC_LVTTHMR);
> > +	apic_write(APIC_LVTTHMR, l | APIC_LVT_MASKED);
> > +
> > +	rdmsr_on_cpu(data->id, MSR_IA32_THERM_INTERRUPT,&eax,&edx);
> 
> apic_write and rdmsr_on_cpu maybe don't point to the same CPU.
> Maybe it is a potential issue. The below apic_xxx etc. are same situations.

Yes. Agreed. Figured out that there is a way to execute a function on a
particular CPU, if we know cpu->id. So, shall modify the patch accordingly
and submit it. 
Sorry for the late response. It took some time to find out how to do this.


Thanks,
Durgadoss
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
